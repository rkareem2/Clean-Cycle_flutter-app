import 'package:clean_cycle/firebase_options.dart';
import 'package:clean_cycle/services/auth/login.dart';
import 'package:clean_cycle/services/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
