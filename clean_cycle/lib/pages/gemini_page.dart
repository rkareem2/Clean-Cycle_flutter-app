import 'package:clean_cycle/pages/chatbot.dart';
import 'package:flutter/material.dart';

class GeminiPage extends StatefulWidget {
  const GeminiPage({super.key});

  @override
  State<GeminiPage> createState() => _MyAppState();
}

class _MyAppState extends State<GeminiPage> {
  bool _isChatVisible = false;

  void _toggleChatVisibility() {
    setState(() {
      _isChatVisible = !_isChatVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Environmental Data Page'),
                  subtitle: const Text('Tap here for Environmental Data'),
                  tileColor: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, '/env_data_page');
                  }
                ),
              ],
            ),
          ),
          if (_isChatVisible)
              Positioned(
              bottom: 75,
              right: 20,
              child: Container(
                width: 350,
                height: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ChatbotSection(), // Replace with your chat content
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleChatVisibility,
        tooltip: (_isChatVisible ? 'Hide Chat' : 'Ask Gemini'),
        child: const Icon(Icons.chat_bubble),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat
    );
  }
}
