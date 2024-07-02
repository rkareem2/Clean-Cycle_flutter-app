import 'package:clean_cycle/Themes/theme_provider.dart';
import 'package:clean_cycle/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:clean_cycle/firebase_options.dart';
import 'package:clean_cycle/services/auth/login.dart';
import 'package:clean_cycle/services/auth/signup.dart';
import 'package:flutter/material.dart';
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
