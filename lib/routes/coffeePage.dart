import 'package:flutter/material.dart';
import 'package:project01/routes/coffeeDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CoffeePage extends StatefulWidget {
  const CoffeePage({super.key, required this.username});

  final String username;


  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {

  int menu = 0;
  var product_id = [];
  var product_name = [];
  var product_price = [];
  var product_image = [];
  bool isLoading = true;

  final IP = '10.210.60.21';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProducts();
  }

  void checkProducts() async {
    try {
      String url = "http://${IP}/mobile/getProducts.php";

      print(url);
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      });
      if (response.statusCode == 200) {
        var rs = response.body.replaceAll('ï»¿', '');

        var product_data = convert.jsonDecode(rs);

        product_data.forEach((value) {
          product_id.add(value['product_id']);
          product_name.add(value['product_name']);
          product_price.add(value['product_price']);
          product_image.add(value['product_image']);
        });

        setState(() {
          isLoading = false;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Triple Ruay Coffee Menu",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          color: const Color.fromARGB(255, 202, 167, 155),
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: product_id.length, // count item I user coffee name
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2)),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoffeeDetail(
                            product_image: product_image[index],
                            product_name: product_name[index],
                            product_price: product_price[index],
                            product_id: product_id[index],
                            username: widget.username,
                          ),
                        ));
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Image.network(
                        height: 50,
                        width: 50,
                        'http://${IP}/mobile/${product_image[index]}',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          product_name[index],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 100, 30, 3),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text("price ${product_price[index]}")
                    ],
                  ),
                ),
              );
            },
          ),
          
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 74, 59, 53),
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.amberAccent,
            currentIndex: menu,
            onTap: (value) {
              setState(() {
                menu = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: "payment"),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "history")
            ]),
    );
  }
}
