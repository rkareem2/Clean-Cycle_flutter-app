import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contribute History'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: const Text('Title'),
              subtitle: const Text('Description'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  print('delete');
                },
              ),
            );
          },
        ));
  }
}
