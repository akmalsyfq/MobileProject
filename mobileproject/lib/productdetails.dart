import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'product.dart';
import 'user.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class Productdetails extends StatefulWidget {
  final Product product;
  final User user;

  const Productdetails({Key? key, required this.user, required this.product})
      : super(key: key);

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  @override
  Widget build(BuildContext context) {
    late double screenHeight, screenWidth;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Product Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: screenHeight / 2,
                  width: screenWidth / 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(1, 3))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5.0) //
                        ),
                    image: DecorationImage(
                        image: NetworkImage(MyConfig.server +
                            "/bellacosa/images/product/" +
                            widget.product.procode +
                            ".png"),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    widget.product.proname.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                Divider(
                  color: Colors.black,
                ),
                const Text(
                  "Description:",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.product.prodesc,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "Quantity:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Price:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.product.proquan,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "RM" + widget.product.proprice,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fixedSize: Size(screenWidth / 3, screenHeight / 15)),
                  child: const Text('Add to cart'),
                  onPressed: () => {
                    _addtocart(),
                  },
                ),
              ],
            ),
          ),
        ));
  }

  _addtocart() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Adding to cart"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(Uri.parse(MyConfig.server + "/bellcosa/php/add_cart.php"), body: {
      "email": widget.user.email,
      "product_id": widget.product.procode
    }).then((response) {
      if (response.body == "Failed") {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        Navigator.pop(context);
      }
    });
    progressDialog.dismiss();
  }
}
