import 'package:clean_cycle/components/chatbot.dart';
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
                const Text('Ask Gemini...', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                buildGeminiSectionButton("assets/logo1.png", "Environmental Data Page", "/env_data_page"),
                const SizedBox(height: 5),
                buildGeminiSectionButton("assets/logo1.png", "Carbon Footprint Tracker", "/carbon_tracker_page"),
                const SizedBox(height: 5),
                buildGeminiSectionButton("assets/logo1.png", "Learning Center", "/carbon_tracker_page")
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

  Widget buildGeminiSectionButton(String imageUrl, String textValue, String routeAddress) {
    return Material (
      color: Colors.blue,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Ink.image(
                image: AssetImage(imageUrl),
                height: 100,
                fit: BoxFit.fill,
              ),
              Text(textValue, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
            ]
          ),
          onTap: () {
            Navigator.pushNamed(context, routeAddress);
          }
        ),
      ),
    );
  }
}
