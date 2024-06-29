import 'package:clean_cycle/pages/home_page.dart';
import 'package:clean_cycle/pages/login.dart';
import 'package:clean_cycle/pages/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        //'/login': (context) => const HomePage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
