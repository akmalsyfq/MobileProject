import 'dart:convert';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobileproject/adminproductpage.dart';
import 'adminpage.dart';
import 'newproduct.dart';
import 'product.dart';
import 'tabpage1.dart';
import 'user.dart';

import 'config.dart';
import 'detailshoppage.dart';

class Ownerhomepage extends StatefulWidget {
  final User user;
  const Ownerhomepage({Key? key, required this.user}) : super(key: key);
  @override
  State<Ownerhomepage> createState() => _OwnerhomepageState();
}

class _OwnerhomepageState extends State<Ownerhomepage> {
  String textCenter = "Loading...";
  late double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dashboard"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                  child: Column(children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
                    );
                  }, // Handle your callback.
                  splashColor: Colors.brown.withOpacity(0.5),
                  child: Ink(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/money.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text("Sale Report")
              ]))),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                    child: Column(children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewProductPage()),
                      );
                    }, // Handle your callback.
                    splashColor: Colors.brown.withOpacity(0.5),
                    child: Ink(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/add.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text("Add Product")
                ]))),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                    child: Column(children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminProductPage()),
                      );
                    }, // Handle your callback.
                    splashColor: Colors.brown.withOpacity(0.5),
                    child: Ink(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/view.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text("Product List")
                ]))),
          ]),
        ],
      )),
    );
  }
}
