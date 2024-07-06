import 'package:clean_cycle/Themes/theme_provider.dart';
import 'package:clean_cycle/pages/map.dart';
import 'package:clean_cycle/services/auth/auth_gate.dart';
import 'package:clean_cycle/services/auth/logout.dart';
import 'package:flutter/material.dart';
import 'package:clean_cycle/firebase_options.dart';
import 'package:clean_cycle/pages/Home_page.dart';
import 'package:clean_cycle/services/auth/login.dart';
import 'package:clean_cycle/services/auth/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      // get theme from theme provider
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/homepage': (context) => const HomePage(),
        '/logout': (context) => const LogoutPage(),
        // ignore: prefer_const_constructors
        '/google_map': (context) => GoogleMapPage(),
      },
    );
  }
}
