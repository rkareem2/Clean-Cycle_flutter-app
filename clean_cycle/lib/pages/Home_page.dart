import 'package:flutter/material.dart';
import 'package:clean_cycle/components/my_drawer.dart';
// Home page

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Simple Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/google_map');
          },
          child: const Text('Open Google Map'),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
