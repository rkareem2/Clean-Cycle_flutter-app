import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Future<String?> queryGemini(String request) async {
  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: "AIzaSyDhiDIX5m5XtX1duWQQ6_Q1FsL9hVG9PdQ");
  final content = [Content.text(request)];
  final response = await model.generateContent(content);
  return response.text;
}

class ChatbotSection extends StatefulWidget {
  const ChatbotSection({super.key});

  @override
  _ChatbotSectionState createState() => _ChatbotSectionState();
}

class _ChatbotSectionState extends State<ChatbotSection> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [{'text': "Hi, I'm Gemini. Ask me something...", 'isUserMessage': false}];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({'text': _controller.text, 'isUserMessage': true});
        _controller.clear();
        _getGeminiReply();
      });
    }
  }

  void _getGeminiReply() {
    Future.delayed(const Duration(seconds: 0), () {
        queryGemini(_messages.last['text']).then((result) {
          if (result != null) {
            String stringResult = result;
            setState(() {
              _messages.add({'text': stringResult, 'isUserMessage': false});
            });
          } else {
            _messages.add({'text': "Gemini reply error: $result", 'isUserMessage': false});
          }
        }).catchError((error) {
          _messages.add({'text': "Error fetching Gemini reply: $error", 'isUserMessage': false});
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUserMessage = message['isUserMessage'] as bool;
                  final alignment = isUserMessage ? Alignment.centerRight : Alignment.centerLeft;
                  final color = isUserMessage ? Colors.grey[300] : Colors.blue[300];

                  return Align(
                    alignment: alignment,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.625),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
                      child: isUserMessage ? Text(message['text']) : MarkdownBody(data: message['text'])
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(hintText: 'Enter your message...'),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
              ],
            ),
          ],
        )
      ),
    );
  }
}