import 'package:flutter/material.dart';
import './home/home_page.dart';
import './pages/login/LoginPage.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
