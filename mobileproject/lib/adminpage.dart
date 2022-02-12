import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'config.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String _titlecenter = "Loading data...";
  List _reportList = [];
  List _money = [];

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Purchase Report'),
        ),
        body: _reportList.isEmpty
            ? Center(
                child: Text(_titlecenter),
              )
            : Column(
                children: [
                  Flexible(
                    flex: 10,
                    child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: _reportList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: Row(
                            children: [
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
                                            "Receipt ID:" +
                                                _reportList[index]
                                                    ['payreceipt'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      const SizedBox(height: 15),
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                            "Customer Name:" +
                                                _reportList[index]['payown'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                            )),
                                      ),
                                      const SizedBox(height: 15),
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                            "Amount Paid: RM" +
                                                (_reportList[index]['paypaid']),
                                            style: const TextStyle(
                                              fontSize: 18,
                                            )),
                                      ),
                                      const SizedBox(height: 15),
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
                                        // _deleteCartDialog(index);
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
                            "TOTAL SALES",
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
                                color: Colors.green),
                          ),
                          // SizedBox(width: 10),
                        ],
                      )),
                ],
              ));
  }

  Future<void> _loadReport() async {
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/load_payment.php"),
        body: {}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        var jsondata = json.decode(response.body);

        setState(() {
          _reportList = jsondata["report"];
          _money = jsondata["price"];
          print(_money);
        });
      }
    });
  }
}
