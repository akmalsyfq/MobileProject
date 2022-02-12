import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'product.dart';

import 'config.dart';
import 'detailshoppage.dart';

class AdminProductPage extends StatefulWidget {
  const AdminProductPage({
    Key? key,
  }) : super(key: key);
  @override
  State<AdminProductPage> createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  late List _productList = [];
  String textCenter = "Loading...";
  late double screenHeight, screenWidth;
  late ScrollController _scrollController;
  int scrollcount = 10;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Shop products"),
        centerTitle: true,
      ),
      body: _productList.isEmpty
          ? Center(
              child: Text(textCenter,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)))
          : Column(
              children: [
                const Divider(
                  color: Colors.black,
                ),
                Flexible(
                    flex: 10,
                    child: GridView.count(
                        crossAxisCount: 2,
                        controller: _scrollController,
                        children: List.generate(scrollcount, (index) {
                          return Container(
                              child: Column(children: [
                            Card(
                                child: InkWell(
                              onTap: () => {(_prodet(index))},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: screenHeight / 5.1,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: NetworkImage(
                                            (MyConfig.server +
                                                "/bellacosa/images/product/" +
                                                _productList[index]["code"] +
                                                ".png"),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        6.0, 0.0, 6.0, 3.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              truncateString(
                                                  _productList[index]["name"]),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              "Quantity:" +
                                                  _productList[index]
                                                      ["quantity"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ]),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        6.0, 0.0, 6.0, 0.0),
                                    child: Row(children: [
                                      Text("RM" + _productList[index]["price"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ]),
                                  ),
                                ],
                              ),
                            ))
                          ]));
                        })))
              ],
            ),
    );
  }

  String truncateString(String str) {
    if (str.length > 10) {
      str = str.substring(0, 10);
      return str + "...";
    } else {
      return str;
    }
  }

  Future<void> _loadProducts() async {
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/loadproducts.php"),
        body: {}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        var extractdata = json.decode(response.body);
        setState(() {
          _productList = extractdata["products"];
          print(_productList);
          if (scrollcount >= _productList.length) {
            scrollcount = _productList.length;
          }
        });
      }
    });
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (_productList.length > scrollcount) {
          scrollcount = scrollcount + 10;
          if (scrollcount >= _productList.length) {
            scrollcount = _productList.length;
          }
        }
      });
    }
  }

  _prodet(int index) {
    Product product = Product(
        proid: _productList[index]['id'],
        procode: _productList[index]['code'],
        proname: _productList[index]['name'],
        prodesc: _productList[index]['prodesc'],
        proprice: _productList[index]['price'],
        proquan: _productList[index]['quantity']);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Detailshoppage(
                  product: product,
                )));
    _loadProducts();
  }
}
