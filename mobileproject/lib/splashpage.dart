import 'dart:async';
import 'package:flutter/material.dart';
import 'mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'user.dart';
import 'dart:convert';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkAndLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff8bbd0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", scale: 1.5),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "BELLA COSA",
                      style: TextStyle(
                          fontSize: 38,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  checkAndLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    late User user;
    if (email.length > 1 && password.length > 1) {
      http.post(Uri.parse(MyConfig.server + "/bellacosa/php/login_user.php"),
          body: {"email": email, "password": password}).then((response) {
        if (response.statusCode == 200 && response.body != "failed") {
          final jsonResponse = json.decode(response.body);
          user = User.fromJson(jsonResponse);

          Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => Mainpage(
                            user: user,
                          ))));
        } else {
          user = User(
              id: "na",
              name: "user",
              email: "na",
              phone: "na",
              address: "na",
              otp: "na");
          Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => Mainpage(
                            user: user,
                          ))));
        }
      }).timeout(const Duration(seconds: 5));
    } else {
      user = User(
          id: "na",
          name: "user",
          email: "na",
          phone: "na",
          address: "na",
          otp: "na");
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => Mainpage(
                        user: user,
                      ))));
    }
  }
}
