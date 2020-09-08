import 'package:flutter/material.dart';
import './home/home_page.dart';
import './home/swiper.dart';
import './home/demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
    );
  }
}
