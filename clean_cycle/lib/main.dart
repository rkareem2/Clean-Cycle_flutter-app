import 'package:clean_cycle/pages/Home_page.dart';
import 'package:clean_cycle/pages/login.dart';
import 'package:clean_cycle/pages/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/homepage': (context) => HomePage(),
        '/signup': (context) => Signup_page(),
        '/login': (context) => LoginPage()
      },
    );
  }
}
