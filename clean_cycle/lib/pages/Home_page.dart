import 'package:clean_cycle/services/gemini/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:clean_cycle/components/my_drawer.dart';
// Home page

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _isChatVisible = false;

  void _toggleChatVisibility() {
    setState(() {
      _isChatVisible = !_isChatVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Simple Home Page'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/google_map');
              },
              child: const Text('Open Google Map'),
            ),
          ),
          Visibility(
            visible: _isChatVisible,
            child: const Expanded(
              child: ChatbotSection()
            )
          ),
          FloatingActionButton(
            onPressed: _toggleChatVisibility,
            tooltip: (_isChatVisible ? 'Hide Chat' : 'Ask Gemini'),
            child: const Icon(Icons.chat_bubble),
          )
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
