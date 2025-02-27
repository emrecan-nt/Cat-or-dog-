import 'package:cat_or_dog/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 917),
      builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cat or Dog ',
          home: const HomePage()),
    );
  }
}
