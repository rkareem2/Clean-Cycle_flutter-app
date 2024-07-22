import 'package:flutter/material.dart';

class ContributePage extends StatelessWidget {
  const ContributePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contribute page'),
      ),
      body: Center(
        child: const Text(
          'No contributions at the moment.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
