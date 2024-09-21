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
            child: ListView(
              children: [
                buildGeminiSectionButton("assets/images/environmental_data.png", "Environmental Data Page", "/env_data_page"),
                const SizedBox(height: 5),
                buildGeminiSectionButton("assets/images/carbon_footprint.png", "Carbon Footprint Tracker", "/carbon_tracker_page"),
                const SizedBox(height: 5),
                buildGeminiSectionButton("assets/images/learning_center.png", "Learning Center", "/learning_center")
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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.chat_bubble),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat
    );
  }

  Widget buildGeminiSectionButton(String imageUrl, String textValue, String routeAddress) {
    return Material (
      color: const Color.fromARGB(255, 50, 50, 50),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Ink.image(
                image: AssetImage(imageUrl),
                height: 175,
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
