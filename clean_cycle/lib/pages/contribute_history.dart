import 'package:flutter/material.dart';

class historyPage extends StatelessWidget {
  const historyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contribute History'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Title'),
              subtitle: Text('Description'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  print('delete');
                },
              ),
            );
          },
        ));
  }
}
