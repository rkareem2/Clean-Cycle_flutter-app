import 'package:clean_cycle/Themes/theme_provider.dart';
import 'package:clean_cycle/pages/contribute_page.dart';
import 'package:clean_cycle/pages/gemini_pages/carbon_tracker_page.dart';
import 'package:clean_cycle/pages/gemini_pages/environmental_data_page.dart';
import 'package:clean_cycle/pages/gemini_pages/learning_center.dart';
import 'package:clean_cycle/pages/map.dart';
import 'package:clean_cycle/pages/Collection_Request.dart';
import 'package:clean_cycle/pages/splashscreen.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      // initialRoute: "/splash",
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/auth': (context) => const AuthGate(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/homepage': (context) => const HomePage(),
        '/logout': (context) => const LogoutPage(),
        '/google_map': (context) => const GoogleMapPage(),
        '/collection_requests': (context) => const CollectionRequestsPage(),
        '/contribute_page': (context) => const ContributePage(),
        '/env_data_page': (context) => const EnvDataPage(),
        '/carbon_tracker_page': (context) => const CarbonTrackerPage(),
        '/learning_center': (context) => LearningCenter(),
      },
    );
  }
}
