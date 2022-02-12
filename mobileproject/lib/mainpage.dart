import 'package:flutter/material.dart';
import 'tabpage1.dart';
import 'tabpage2.dart';
import 'tabpage3.dart';
import 'user.dart';

class Mainpage extends StatefulWidget {
  final User user;
  const Mainpage({Key? key, required this.user}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Home";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      TabPage1(
        user: widget.user,
      ),
      TabPage2(
        user: widget.user,
      ),
      TabPage3(
        user: widget.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Home";
      }
      if (_currentIndex == 1) {
        maintitle = "Cart";
      }
      if (_currentIndex == 2) {
        maintitle = "Profile";
      }
    });
  }
}
