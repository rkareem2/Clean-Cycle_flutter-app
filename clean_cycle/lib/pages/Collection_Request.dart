import 'package:flutter/material.dart';

class CollectionRequestsPage extends StatelessWidget {
  const CollectionRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'No collection requests at the moment.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
