import 'package:flutter/material.dart';
import 'user.dart';

class HelpCenter extends StatefulWidget {
  final User user;
  const HelpCenter({Key? key, required this.user}) : super(key: key);
  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  get advancedTiles => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Help Center",
        style: TextStyle(color: Colors.white),
      )),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("How can we help you?",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/info.png",
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: const <Widget>[
                        ExpansionTile(
                          title: Text(
                            "Frequently Asked Questions (FAQ)",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            ExpansionTile(
                              title: Text(
                                'How can I make payment?',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                      'You can make payment through online or cash payment at the store.'),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              title: Text(
                                'Is there a minimum order value?',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                      'No, there is no minimum order value.'),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              title: Text(
                                'How can I apply for a return and refund?',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                      'Good sold are not returnable and refundable. However, if there is any problem with the goods, you may visit the physical shop to apply for return and refund.'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ExpansionTile(
                          title: Text(
                            "About Us",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            ExpansionTile(
                              title: Text(
                                'Shop Address',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                      'Universiti Utara Malaysia, Sintok, 06010 Bukit Kayu Hitam, Kedah'),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              title: Text(
                                'Shop Contact',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                      '''Phone: +6011-56364789                      
Email: admin@shop.com'''),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
