import 'package:flutter/material.dart';
import 'package:project01/admin.dart';
import 'package:project01/routes/coffeePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(const Project01());
}

class Project01 extends StatelessWidget {
  const Project01({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              )),
              color: Color.fromARGB(255, 74, 59, 53))),
      home: const CoffeeShop(),
    );
  }
}

class CoffeeShop extends StatefulWidget {
  const CoffeeShop({super.key});

  @override
  State<CoffeeShop> createState() => _CoffeeShopState();
}

class _CoffeeShopState extends State<CoffeeShop> {

  bool hindPassword = true;

  TextEditingController us = TextEditingController();
  TextEditingController pw = TextEditingController();

  var resultLogin = '', login = '', st = '';
  final IP = '10.210.60.21';

  void checkLogin(String username, String password) async {
    try {
      String url = "http://${IP}/mobile/login.php?us=$username&pw=$password";

      print(url);
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8'
      });
        var rs = response.body.replaceAll('ï»¿', '');
        var rsLogin = convert.jsonDecode(rs);

      if (response.statusCode == 200) {
        setState(() {
          login = rsLogin['login'];
          if (login.contains('OK')) {

            st = rsLogin["status"];

            if (st.contains("user")){
              Navigator.push(context,
              MaterialPageRoute(builder:
              (context) => CoffeePage(username: us.text,)));
            } else {
              Navigator.push(context,
              MaterialPageRoute(builder:
              (context) => const AdminPage()));
            }
            
          } else {
            showAlert(context, "Invalid login", "Username or password is not correct");
          }
        });
        
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      print(e);
    }
  }

  void showAlert(BuildContext context, String t, String msg){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$t"),
          content: Text("$msg"),
          actions: [
            Card(
              color: const Color.fromARGB(255, 188, 16, 4),
              child: ListTile(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                title: const Center(child: Text("OK"),),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Triple Ruay Coffee Shop",
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(Icons.coffee, color: Colors.white,),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50,bottom: 10, left: 15, right: 15),
              child: TextField(
                controller: us,
                decoration: const InputDecoration(
                  hintText:  "Username",
                  suffixIcon: Icon(Icons.person_2_sharp),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 74, 59, 53),
                    )
                  )
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 10,bottom: 10, left: 15, right: 15),
              child: TextField(
                controller: pw,
                obscureText: hindPassword,
                decoration: InputDecoration(
                  suffixIcon:  IconButton(
                    onPressed: () {
                      setState(() {
                        hindPassword =! hindPassword;
                      });
                    },
                    icon: Icon(hindPassword? Icons.visibility_off: Icons.visibility)),
                  hintText: "Password",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 74, 59, 53)
                    )
                  )
                ),
              ),
            ),

            Container(
              padding:const EdgeInsets.only(top:30, left: 50, right: 50),
              child: Card(
                  color: const Color.fromARGB(255, 126, 37, 2),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        if(us.text.isEmpty || pw.text.isEmpty){
                          showAlert(context, "sign it", "Please sign your Username and Password");
                          us.clear();
                          pw.clear();
                        } else {
                          checkLogin(us.text, pw.text);
                        }
                        
                      });
                    },
                    title: const Center(
                      child: Text("Login",
                      style: TextStyle(
                        color: Colors.white),
                      ),
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
