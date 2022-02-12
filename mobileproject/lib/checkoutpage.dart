import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobileproject/paymentpage.dart';
import 'address.dart';
import 'dart:convert';
import 'package:mobileproject/addresspage.dart';

import 'payment.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class CheckOut extends StatefulWidget {
  final double total;
  final User user;

  const CheckOut({
    Key? key,
    required this.total,
    required this.user,
  }) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  String _titlecenter = "Loading data...";
  List _cartList = [];
  List _money = [];
  List _addressList = [];
  int data = 0;
  double _totalprice = 0.0;

  @override
  void initState() {
    super.initState();
    _loadMyCart();
  }

  @override
  Widget build(BuildContext context) {
    var i = 0;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Payment Checkout"),
        ),
        body: _cartList.isEmpty
            ? Center(
                child: Text(_titlecenter),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    flex: 10,
                    child: ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: Container(
                                  height: 125,
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(5.0, 8.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                            child: CachedNetworkImage(
                                              imageUrl: MyConfig.server +
                                                  "/bellacosa/images/product/" +
                                                  _cartList[index]
                                                      ["product_id"] +
                                                  ".png",
                                              placeholder: (context, url) =>
                                                  new CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            ),
                                          )),
                                      Expanded(
                                        flex: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                    _cartList[index]
                                                        ['product_name'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              const SizedBox(height: 12),
                                              Text("Item Details:",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "RM " +
                                                        (int.parse(_cartList[
                                                                        index][
                                                                    'cartqty']) *
                                                                double.parse(
                                                                    _cartList[
                                                                            index]
                                                                        [
                                                                        'product_price']))
                                                            .toStringAsFixed(2),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    "Quantity: " +
                                                        (int.parse(_cartList[
                                                                    index]
                                                                ['cartqty']))
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )));
                        }),
                  ),
                  Flexible(
                      flex: 3,
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "DELIVERY ADDRESS",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      Column(
                                        children: [
                                          if (_addressList.isEmpty)
                                            GestureDetector(
                                              onTap: () async {
                                                Address address =
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (content) =>
                                                                AddressPage(
                                                                    user: widget
                                                                        .user,
                                                                    chooseAddress:
                                                                        true)));
                                                setState(() {
                                                  _loadAddress();
                                                  if (_addressList.isEmpty) {
                                                    Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/noaddress.png",
                                                          height: 150,
                                                          width: 150,
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                            'Address Is Empty! Tap To Insert!',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        SizedBox(height: 20),
                                                      ],
                                                    ));
                                                    return;
                                                  }
                                                  address == null
                                                      ? data = 0
                                                      : data = address.data;
                                                });
                                              },
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/noaddress.png",
                                                      height: 150,
                                                      width: 150,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    const Text(
                                                        'Address Is Empty! Tap To Insert!',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    const SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                            )
                                          else
                                            data >= _addressList.length
                                                ? Container(
                                                    color: Colors.white,
                                                    child: SpinKitFadingCircle(
                                                      size: 50,
                                                    ))
                                                : Container(
                                                    decoration:
                                                        const BoxDecoration(),
                                                    child: GridView.count(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        crossAxisCount: 1,
                                                        childAspectRatio:
                                                            2.2 / 1,
                                                        children: List.generate(
                                                            1, (index) {
                                                          return GestureDetector(
                                                              onTap: () async {
                                                                Address address = await Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (content) => AddressPage(
                                                                            user:
                                                                                widget.user,
                                                                            chooseAddress: true)));
                                                                setState(() {
                                                                  _loadAddress();
                                                                  if (_addressList
                                                                      .isEmpty) {
                                                                    Center(
                                                                        child:
                                                                            Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/images/noaddress.png",
                                                                          height:
                                                                              150,
                                                                          width:
                                                                              150,
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        const Text(
                                                                            'Address Is Empty! Tap To Insert!',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                            )),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                      ],
                                                                    ));
                                                                    return;
                                                                  }
                                                                  address ==
                                                                          null
                                                                      ? data = 0
                                                                      : data =
                                                                          address
                                                                              .data;
                                                                });
                                                              },
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          3),
                                                                  child: Card(
                                                                      child:
                                                                          Container(
                                                                    decoration: const BoxDecoration(
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey,
                                                                            offset:
                                                                                Offset(5.0, 8.0),
                                                                            blurRadius:
                                                                                6.0,
                                                                          ),
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                10)),
                                                                        color: Colors
                                                                            .white),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              9,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(5.0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(children: [
                                                                                  const Text("Name: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                                                  Text(data == null ? _addressList[0]['name'] : _addressList[data]["name"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                                                ]),
                                                                                const Divider(
                                                                                  color: Colors.black,
                                                                                ),
                                                                                Row(children: [
                                                                                  const Text("Contact Number: "),
                                                                                  Text(
                                                                                    data == null ? _addressList[0]['phone'] : _addressList[data]["phone"],
                                                                                    style: const TextStyle(
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  )
                                                                                ]),
                                                                                SizedBox(
                                                                                  height: 1,
                                                                                ),
                                                                                Row(children: [
                                                                                  const Text("Address: "),
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      data == null ? (_addressList[0]['address']) : (_addressList[data]['address']),
                                                                                      style: const TextStyle(
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      maxLines: 5,
                                                                                    ),
                                                                                  )
                                                                                ])
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ))));
                                                        })),
                                                  ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "TAP TO CHANGE",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "TOTAL AMOUNT PAYABLE",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "RM " + widget.total.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          Container(
                            //width: screenWidth / 2.5,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_addressList.length == 0) {
                                  Fluttertoast.showToast(
                                      msg: "Please choose an address.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 16.0);
                                  return;
                                } else {
                                  _paynowDialog();
                                }
                              },
                              child: Text("PAY NOW"),
                            ),
                          )
                        ],
                      ))
                ],
              ));
  }

  Future<void> _loadMyCart() async {
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/load_cart.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        setState(() {
          _titlecenter = "No item in your cart";
          _cartList = [];
          _totalprice = 0.0;
        });
        return;
      } else {
        var jsondata = json.decode(response.body);

        setState(() {
          _cartList = jsondata["cart"];
          _money = jsondata["price"];
          print(_money);
          //double _total = _money[0]['total'];
        });
      }
      _totalprice = _money[0]['total'].toDouble(); // _money[0]['total'];

      print(_totalprice);
    });
  }

  Future<void> _loadAddress() async {
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/load_address.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        setState(() {
          _titlecenter = "No Address";
          _addressList = [];
          print(response.body);
        });
        return;
      } else {
        setState(() {
          var jsondata = json.decode(response.body);
          _addressList = jsondata["address"];
          print(jsondata);
        });
      }
    });
  }

  void _paynowDialog() {
    showDialog(
        builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: Text(
                  "Proceed to payment",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                content: new Text(
                  'Pay RM ' + widget.total.toStringAsFixed(2) + "?",
                  style: TextStyle(),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Payment payment = new Payment(
                          widget.user.email.toString(),
                          widget.user.phone.toString(),
                          widget.user.name.toString(),
                          widget.total.toString());
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentPage(payment: payment, user: widget.user),
                        ),
                      );
                    },
                  ),
                  TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }
}
