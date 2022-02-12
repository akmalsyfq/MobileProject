import 'package:flutter/material.dart';
import 'drawer.dart';
import 'product.dart';
import 'productdetails.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'config.dart';

class TabPage1 extends StatefulWidget {
  final User user;
  const TabPage1({Key? key, required this.user}) : super(key: key);

  @override
  State<TabPage1> createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  late List _productList = [];
  String textCenter = "Loading...";
  late double screenHeight, screenWidth;
  late ScrollController _scrollController;
  int scrollcount = 6;

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
        centerTitle: true,
        title: Text(
            "Welcome, " + (widget.user.name.toString().toUpperCase()) + "!"),
      ),
      endDrawer: SlidingDrawer(user: widget.user),
      body: _productList.isEmpty
          ? Center(
              child: Text(textCenter,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)))
          : Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Special Deals",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Icon(Icons.local_offer)
                  ],
                ),
                CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                    ),
                    items: [
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Stack(children: [
                            Image.asset("assets/images/delivery.png",
                                fit: BoxFit.cover, width: 1000.0),
                          ]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Stack(children: [
                            Image.asset("assets/images/sale.png",
                                fit: BoxFit.cover, width: 1000.0),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                  height: 80,
                                  color: Colors.white.withOpacity(0.7),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text("Enjoy 20% discount",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black)),
                                      Text("with our special deals ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ))
                                    ],
                                  )),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Stack(children: [
                            Image.asset("assets/images/shop.png",
                                fit: BoxFit.cover, width: 1000.0),
                          ]),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                const Text("Shop Products",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(
                  color: Colors.black,
                ),
                Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        controller: _scrollController,
                        children: List.generate(scrollcount, (index) {
                          return Column(children: [
                            Container(
                                child: Column(children: [
                              Card(
                                  child: InkWell(
                                onTap: () => {(_prodet(index))},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: screenHeight / 7,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
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
                                          6.0, 0.0, 6.0, 6.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(_productList[index]["name"],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            IconButton(
                                                icon: const Icon(Icons
                                                    .favorite_border_outlined),
                                                tooltip: 'Add to wishlist',
                                                onPressed: () {}),
                                          ]),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          6.0, 0.0, 6.0, 6.0),
                                      child: Row(children: [
                                        Text(
                                            "RM" + _productList[index]["price"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const Spacer(),
                                      ]),
                                    ),
                                  ],
                                ),
                              ))
                            ]))
                          ]);
                        })))
              ],
            ),
    );
  }

  Future<void> _loadProducts() async {
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/loadproducts.php"),
        body: {}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        var extractdata = json.decode(response.body);
        //print(extractdata);
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
            builder: (BuildContext context) =>
                Productdetails(product: product, user: widget.user)));
    _loadProducts();
  }
}
