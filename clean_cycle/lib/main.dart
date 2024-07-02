import 'package:clean_cycle/Themes/theme_provider.dart';
import 'package:clean_cycle/pages/home_page.dart';
import 'package:clean_cycle/pages/login.dart';
import 'package:clean_cycle/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      // get theme from theme provider 
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/login': (context) => const LoginPage(),
        //'/login': (context) => const HomePage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
