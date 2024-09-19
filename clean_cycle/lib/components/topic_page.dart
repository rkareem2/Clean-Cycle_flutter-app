import 'package:flutter/material.dart';

class TopicPage extends StatelessWidget {
  final String title;

  const TopicPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Content for $title', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}