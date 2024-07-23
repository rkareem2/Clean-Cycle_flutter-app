import 'package:flutter/material.dart';

class CollectionRequestsPage extends StatelessWidget {
  const CollectionRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collection Requests"),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
