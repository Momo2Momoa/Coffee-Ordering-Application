import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<String> userNames = []; // เก็บชื่อผู้ใช้
  List<String> firstNames = []; // เก็บชื่อจริง
  List<String> lastNames = []; // เก็บนามสกุล

  List<String> productIds = [];
  List<String> orderNumbers = [];
  List<String> orderDates = [];
  List<String> orderStatuses = [];

  List<String> productImages = [];
  List<String> productNames = [];
  List<String> productPrices = [];

  bool isLoading = true;

  final String IP = '10.210.60.21';

  void checkOrders() async {
    try {
      String url = "http://$IP/mobile/getOrders.php";
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      });
      if (response.statusCode == 200) {
        var productData = convert.jsonDecode(response.body.replaceAll('ï»¿', ''));
        productData.forEach((value) {
          userNames.add(value['user_name']);
          productIds.add(value['product_id']);
          orderNumbers.add(value['order_num']);
          orderDates.add(value['order_date']);
          orderStatuses.add(value['order_status']);
        });
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print(e);
    }
  }

  void checkProducts() async {
    try {
      String url = "http://$IP/mobile/getProducts.php";
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      });
      if (response.statusCode == 200) {
        var productData = convert.jsonDecode(response.body.replaceAll('ï»¿', ''));
        productData.forEach((value) {
          productIds.add(value['product_id']);
          productNames.add(value['product_name']);
          productPrices.add(value['product_price']);
          productImages.add(value['product_image']);
        });
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print(e);
    }
  }

  void checkUsers() async {
    try {
      String url = "http://$IP/mobile/getUsers.php";
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      });
      if (response.statusCode == 200) {
        var userData = convert.jsonDecode(response.body.replaceAll('ï»¿', ''));
        userData.forEach((value) {
          userNames.add(value['user_name']);
          firstNames.add(value['firstname']);
          lastNames.add(value['lastname']);
        });
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    checkOrders();
    checkProducts();
    checkUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color.fromARGB(255, 202, 167, 155),
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: orderNumbers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2),
                ),
                itemBuilder: (BuildContext context, int index) {
                  double price = double.parse(productPrices[index]);
                  int quantity = int.parse(orderNumbers[index]);
                  double totalPrice = price * quantity;

                  String userFirstName = '';
                  String userLastName = '';
                  int userIndex = userNames.indexOf(userNames[index]);

                  if (userIndex != -1) {
                    userFirstName = firstNames[userIndex];
                    userLastName = lastNames[userIndex];
                  }

                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            "${productNames[index]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Image.network(
                            height: 100,
                            width: 100,
                            'http://$IP/mobile/${productImages[index]}',
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "จำนวน: ${orderNumbers[index]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "ราคา: ${productPrices[index]} / เป็นเงิน: $totalPrice บาท",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "ชื่อผู้สั่งซื้อ: $userFirstName $userLastName",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "วันเวลาที่สั่งซื้อ: ${orderDates[index]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "สถานะการสั่งซื้อ: ${orderStatuses[index]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
