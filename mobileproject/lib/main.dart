import 'package:flutter/material.dart';
import 'splashpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
          appBarTheme: const AppBarTheme(color: Color(0xfff06292)),
        ),
        title: 'Bella Cosa',
        home: const Scaffold(
          body: SplashPage(),
        ));
  }
}
