import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'checkoutpage.dart';
import 'config.dart';

class TabPage2 extends StatefulWidget {
  final User user;
  const TabPage2({Key? key, required this.user}) : super(key: key);

  @override
  _TabPage2State createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> {
  String _titlecenter = "Loading data...";
  List _cartList = [];
  List _money = [];
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
          title: Text((widget.user.name.toString().toUpperCase()) + "'s Cart"),
        ),
        body: _cartList.isEmpty
            ? Center(
                child: Text(_titlecenter),
              )
            : Column(
                children: [
                  Flexible(
                    flex: 10,
                    child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: _cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: CachedNetworkImage(
                                      imageUrl: MyConfig.server +
                                          "/bellacosa/images/product/" +
                                          _cartList[index]["product_id"] +
                                          ".png",
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  )),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                            _cartList[index]['product_name'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "RM " +
                                            (int.parse(_cartList[index]
                                                        ['cartqty']) *
                                                    double.parse(
                                                        _cartList[index]
                                                            ['product_price']))
                                                .toStringAsFixed(2),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              child: SizedBox(
                                                  height: 30.0,
                                                  width: 20.0,
                                                  child: IconButton(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    icon: new Icon(Icons.remove,
                                                        size: 20),
                                                    onPressed: () {
                                                      _modQty(
                                                          index, "removecart");
                                                    },
                                                  ))),
                                          Container(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              width: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              child: SizedBox(
                                                height: 30.0,
                                                width: 100.0,
                                                child: Center(
                                                  child: Text(_cartList[index]
                                                      ['cartqty']),
                                                ),
                                              )),
                                          Container(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              child: SizedBox(
                                                  height: 30.0,
                                                  width: 20.0,
                                                  child: IconButton(
                                                    padding:
                                                        new EdgeInsets.all(0.0),
                                                    icon: new Icon(Icons.add,
                                                        size: 20),
                                                    onPressed: () {
                                                      _modQty(index, "addcart");
                                                    },
                                                  ))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteCartDialog(index);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ));
                        }),
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "TOTAL",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "RM " +
                                (_money[0]['total'])
                                    .toDouble()
                                    .toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          // SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              _payDialog();
                            },
                            child: const Text("CHECKOUT"),
                          ),
                        ],
                      )),
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

  Future<void> _modQty(int index, String s) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Updating your cart"),
        title: const Text("Please wait..."));
    progressDialog.show();
    await Future.delayed(const Duration(seconds: 1));
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/update_cart.php"),
        body: {
          "email": widget.user.email,
          "op": s,
          "product_id": _cartList[index]['product_id'],
          "qty": _cartList[index]['cartqty']
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Update Success",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  Future<void> _deleteCart(int index) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Delete from cart"),
        title: const Text("Progress..."));
    progressDialog.show();
    await Future.delayed(const Duration(seconds: 1));
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/delete_cart.php"),
        body: {
          "email": widget.user.email,
          "product_id": _cartList[index]['product_id']
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Successfully deleted",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed to delete",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  void _deleteCartDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete item from your cart?',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteCart(index);
                    },
                  ),
                  TextButton(
                      child: const Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  void _payDialog() {
    if (_money == 0.0) {
      Fluttertoast.showToast(
          msg: "Cart Is Empty.",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
      return;
    } else {
      showDialog(
          builder: (context) => new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  title: new Text(
                    'Proceed with checkout?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => CheckOut(
                                    user: widget.user, total: _totalprice),
                              ),
                            )
                            .then((_) => setState(() {
                                  _loadMyCart();
                                }));
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
}
