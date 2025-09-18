import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CoffeeDetail extends StatefulWidget {
  const CoffeeDetail({super.key, required this.product_image,
  required this.product_name, required this.product_price,
  required this.product_id, required this.username});

  final String product_image;
  final String product_name;
  final String product_price;
  final String product_id;
  final String username;


  @override
  State<CoffeeDetail> createState() => _CoffeeDetailState();
}

class _CoffeeDetailState extends State<CoffeeDetail> {

  int order_num=1;
  final IP = '10.210.60.21';

  void insertOrder(String user_name, String product_id, int order_num) async {
    try {
      String url = "http://${IP}/mobile/insertOrder.php?user_name=$user_name&product_id=$product_id&order_num=$order_num";

      print(url);
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      });
      if (response.statusCode == 200) {
        var rs = response.body.replaceAll('ï»¿', '');
        var rsInsert = convert.jsonDecode(rs);

        String result=rsInsert['order'];

        if(result.contains('OK')){
          print('Order Successfully');
        }else{
          print('Order Fail!!!');
        }
       
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
    //print(widget.cost);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product_name,
        style: TextStyle(color: Colors.yellow),),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network('http://${IP}/mobile/${widget.product_image}',
            width: 250,
            height: 300,),

            Text('ราคา ${widget.product_price} บาท'),
            // Text('ราคา ${detail[widget.id]}',
            //   maxLines: 10,
            //   overflow: TextOverflow.ellipsis,),

            Container(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(onPressed: () {
                      setState(() {
                        order_num--;
                        if(order_num<1){ order_num=1; }
                      });
                    }, icon: Icon(Icons.remove,color: Colors.white,)),
                    ),
                   
                    Text('   ${order_num}  แก้ว   ', style: TextStyle(fontSize: 25),),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(onPressed: () {
                      setState(() {
                        order_num++;
                      });
                    }, icon: Icon(Icons.add, color: Colors.white,)),
                    )
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 20,left: 80,right: 80),
              child: Card(
                color: const Color.fromARGB(255, 4, 68, 6),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      insertOrder(widget.username, widget.product_id, order_num);
                    });
                  },
                  title: Center(child: Text('ยืนยันสั่งซื้อ',style: TextStyle(color: Colors.yellow),)),
                ),
              ),
            )
       
          ],
        ),
      ),
    );
  }
}