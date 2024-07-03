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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text('Simple Home Page')),
      drawer: Drawer(),
    );
  }
}
