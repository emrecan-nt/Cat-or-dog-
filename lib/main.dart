
import 'package:cat_or_dog/HomePage.dart';
import 'package:flutter/material.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cat or Dog",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
