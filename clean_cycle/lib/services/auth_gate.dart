import 'package:clean_cycle/pages/homepage.dart';
import 'package:clean_cycle/services/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // user logged in
            if (snapshot.hasData) {
              return const HomePage();
            }

            // user is not logged in
            else {
              return const LoginPage();
            }
          }),
    );
  }
}
