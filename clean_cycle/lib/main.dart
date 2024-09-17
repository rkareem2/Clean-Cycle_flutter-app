import 'package:clean_cycle/Themes/theme_provider.dart';
import 'package:clean_cycle/pages/chat_pages/chat_list.dart';
import 'package:clean_cycle/pages/collection_center.dart';
import 'package:clean_cycle/pages/contribute_page.dart';
import 'package:clean_cycle/pages/gemini_pages/carbon_tracker_page.dart';
import 'package:clean_cycle/pages/gemini_pages/environmental_data_page.dart';
import 'package:clean_cycle/pages/gemini_pages/learning_center.dart';
import 'package:clean_cycle/pages/map.dart';
import 'package:clean_cycle/pages/splashscreen.dart';
import 'package:clean_cycle/services/auth_gate.dart';
import 'package:clean_cycle/services/logout.dart';
import 'package:flutter/material.dart';
import 'package:clean_cycle/firebase_options.dart';
import 'package:clean_cycle/pages/homepage.dart';
import 'package:clean_cycle/services/login.dart';
import 'package:clean_cycle/services/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;
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
      home: const SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/auth': (context) => const AuthGate(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/homepage': (context) => const HomePage(),
        '/logout': (context) => const LogoutPage(),
        '/google_map': (context) => const GoogleMapPage(),
        '/collection_center': (context) => const CollectionCenter(),
        '/contribute_page': (context) => const ContributePage(),
        '/chat_rooms': (context) => const ChatListPage(),
        '/env_data_page': (context) => const EnvDataPage(),
        '/carbon_tracker_page': (context) => const CarbonTrackerPage(),
        '/learning_center': (context) => LearningCenter(),
      },
    );
  }
}
