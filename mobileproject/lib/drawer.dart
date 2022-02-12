import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'loginnew.dart';
import 'helpcenter.dart';
import 'ownerhomepage.dart';
import 'user.dart';

class SlidingDrawer extends StatefulWidget {
  final User user;
  const SlidingDrawer({Key? key, required this.user}) : super(key: key);

  @override
  _SlidingDrawerState createState() => _SlidingDrawerState();
}

class _SlidingDrawerState extends State<SlidingDrawer> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: Drawer(
            child: Container(
          color: Colors.transparent,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(widget.user.name.toString(),
                      style: TextStyle(color: Colors.black)),
                  accountEmail: Text(widget.user.email.toString(),
                      style: TextStyle(color: Colors.black))),
              SizedBox(height: 5),
              Container(
                  color: Colors.yellow[100],
                  child: ListTile(
                    title: Text("Shop owner",
                        style: TextStyle(color: Colors.black)),
                    leading: Icon(Icons.login, color: Colors.black),
                    onTap: () {
                      if (widget.user.email != "admin@shop.com") {
                        Fluttertoast.showToast(
                            msg: "You are not the shop owner",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) =>
                                    Ownerhomepage(user: widget.user)));
                      }
                    },
                  )),
              const SizedBox(height: 5),
              Container(
                  color: Colors.yellow[400],
                  child: ListTile(
                    title: Text("Help Center",
                        style: TextStyle(color: Colors.black)),
                    leading:
                        Icon(Icons.help_outline_sharp, color: Colors.black),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>
                                  HelpCenter(user: widget.user)));
                    },
                  )),
              const SizedBox(height: 5),
              Container(
                  color: Colors.red,
                  child: ListTile(
                    title:
                        Text("Log Out", style: TextStyle(color: Colors.black)),
                    leading: Icon(Icons.logout, color: Colors.black),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (content) => LoginScreen()));
                    },
                  )),
            ],
          ),
        )));
  }
}
