import 'package:clean_cycle/pages/login.dart';
import 'package:flutter/material.dart';
// Home page

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            SizedBox(width: 20), // Add some space between the buttons
            ElevatedButton(
              child: Text("Sign Up"),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
