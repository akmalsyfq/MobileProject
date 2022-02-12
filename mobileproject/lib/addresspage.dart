import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'addaddresspage.dart';
import 'package:ndialog/ndialog.dart';

import 'address.dart';
import 'config.dart';
import 'user.dart';

class AddressPage extends StatefulWidget {
  final User user;
  final bool chooseAddress;

  const AddressPage({
    Key? key,
    required this.user,
    required this.chooseAddress,
  }) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String _titlecenter = "";
  List _addressList = [];
  late Address address;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Address',
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addAddress();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            if (_addressList.isEmpty)
              Flexible(
                  child: Center(
                child: _titlecenter == ""
                    ? Container()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/noaddress.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(height: 10),
                          Text('Address Is Empty!',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 20),
                        ],
                      ),
              ))
            else
              Flexible(
                  child: Container(
                decoration: BoxDecoration(),
                child: GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 2 / 1,
                    children: List.generate(_addressList.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.chooseAddress == false) {
                            return;
                          } else {
                            _chooseAddress(index);
                          }
                        },
                        child: Padding(
                            padding: EdgeInsets.all(3),
                            child: Card(
                                child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Receiver Name: " +
                                                  _addressList[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Divider(
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Contact: " +
                                                _addressList[index]['phone'],
                                            style: TextStyle(
                                              height: 1.5,
                                              fontSize: 15,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            titleSub(
                                                _addressList[index]['address']),
                                            style: TextStyle(
                                              height: 1.5,
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
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
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            _deleteAddressDialog(index);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                      );
                    })),
              )),
          ],
        ),
      ),
    );
  }

  String titleSub(String title) {
    if (title.length > 120) {
      return title.substring(0, 120) + "...";
    } else {
      return title;
    }
  }

  _loadAddress() {
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/load_address.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No Address";
        _addressList = [];
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _addressList = jsondata["address"];
        print(jsondata);
      }
      setState(() {});
    });
  }

  Future<void> _deleteAddress(int index) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Deleting address"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/delete_address.php"),
        body: {
          "email": widget.user.email,
          "name": _addressList[index]['name'],
          "address": _addressList[index]['address'],
          "phone": _addressList[index]['phone'],
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        _loadAddress();
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  void _deleteAddressDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete your address?',
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteAddress(index);
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

  Future<void> _addAddress() async {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Do you want to add new address?',
          style: TextStyle(),
        ),
        content: new Text(
          'Are your sure?',
          style: TextStyle(),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) =>
                                AddAddressPage(email: widget.user.email)))
                    .then((_) => setState(() {
                          _loadAddress();
                        }));
              },
              child: Text(
                "Yes",
                style: TextStyle(),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "No",
                style: TextStyle(),
              )),
        ],
      ),
    );
  }

  void _chooseAddress(index) {
    address = Address(index);
    Navigator.pop(context, address);
  }
}
