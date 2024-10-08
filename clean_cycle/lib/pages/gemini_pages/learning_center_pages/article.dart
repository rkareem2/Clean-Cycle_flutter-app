import 'package:clean_cycle/components/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GeminiArticle extends StatefulWidget {
  const GeminiArticle({super.key});

  @override
  GeminiArticleState createState() => GeminiArticleState();
}

class GeminiArticleState extends State<GeminiArticle> {
  final TextEditingController _controller = TextEditingController();
  String? _response;

  void _onSubmit() async {
    setState(() { _response = ""; });
    final request = "Write an article on ${_controller.text}";
    final result = await queryGemini(request);
    setState(() {
      _response = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Articles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a topic',
              ),
              onSubmitted: (value) {
                _onSubmit();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onSubmit,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            _response != null
                ? Expanded(
                    child: (_response == '') ? const Center(child: CircularProgressIndicator()) : Markdown(
                      data: _response ?? ''
                    ),
                  )
                : const Center(
                    child: Text('Enter a topic to generate content'),
                  ),
          ],
        ),
      ),
    );
  }
}
