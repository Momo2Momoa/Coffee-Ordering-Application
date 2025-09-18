import 'package:flutter/material.dart';
import 'package:project01/routes/customer.dart';
import 'package:project01/routes/order.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  int id = 0;
  var  title = ['ข้อมูลการสั่งซื้อ', 'ข้อมูลลูกค้า'];

  final List<Widget> pages = [
    OrderPage(),
    CustomerPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.coffee, color:Colors.white),
        title: Text("where house for admin", style: TextStyle(color: Colors.white),),
      ),
      body: pages[id],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 74, 59, 53),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromARGB(255, 218, 221, 8),
        currentIndex: id,
        onTap: (value) {
          setState(() {
            id = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: "order items"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: "customer")
        ]),
    );
  }
}