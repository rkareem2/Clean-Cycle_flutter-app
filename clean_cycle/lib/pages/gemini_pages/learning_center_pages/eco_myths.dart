import 'package:clean_cycle/components/chatbot.dart';
import 'package:flutter/material.dart';

class EcoMythsPage extends StatefulWidget {
  const EcoMythsPage({super.key});

  @override
  EcoMythsPageState createState() => EcoMythsPageState();
}

class EcoMythsPageState extends State<EcoMythsPage> {
  List<Flashcard> _flashcards = [];
  bool _isLoading = false;

  Future<void> _generateFlashcards() async {
    _flashcards = [];
    setState(() {
      _isLoading = true;
    });

    const request = "Generate 5 flashcards on environmental misconceptions.";
    final response = await queryGemini(request);

    if (response != null) {
      setState(() {
        List<String> results = response.split('\n').where((card) => card.trim().isNotEmpty).toList();
        for (int i = 0; i < results.length; i++) {
          if (results[i].contains("**Front:**")) {
            _flashcards.add(Flashcard(front: results[i].replaceAll("**", "").replaceFirst("Front: ", ""), back: results[i + 1].replaceAll("**", "").replaceFirst("Back: ", "")));
          }
        }
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _generateFlashcards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Myths'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _flashcards.length,
                      itemBuilder: (context, index) {
                        return FlashcardWidget(flashcard: _flashcards[index]);
                      },
                    ),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateFlashcards,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
              child: const Text('Generate New Flashcards', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class Flashcard {
  final String front;
  final String back;
  bool isFlipped;

  Flashcard({required this.front, required this.back, this.isFlipped = false});
}

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;

  const FlashcardWidget({super.key, required this.flashcard});

  @override
  FlashcardWidgetState createState() => FlashcardWidgetState();
}

class FlashcardWidgetState extends State<FlashcardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _toggleCard() {
    if (widget.flashcard.isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      widget.flashcard.isFlipped = !widget.flashcard.isFlipped;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * 3.14159; // pi for 180 degree rotation
          return Transform(
            transform: Matrix4.rotationY(angle),
            alignment: Alignment.center,
            child: angle >= 1.5708 // pi/2
                ? Transform(
                    transform: Matrix4.rotationY(3.14159), // Flip text back
                    alignment: Alignment.center,
                    child: Card(
                      key: const ValueKey(true),
                      color: Colors.lightGreenAccent[700],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.flashcard.back,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  )
                : Card(
                    key: const ValueKey(false),
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.flashcard.front,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}