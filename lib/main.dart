import 'package:flutter/material.dart';
import 'package:flutter_sqflite/screens/home.dart';

void main() {
  WidgetsFlutterBinding();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      title: "SQF Lite",
      home: HomePage(),
    );
  }
}
