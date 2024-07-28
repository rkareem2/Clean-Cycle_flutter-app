import 'package:clean_cycle/pages/gemini_pages/learning_center.dart';
import 'package:clean_cycle/pages/gemini_pages/learning_center_pages/eco_quiz.dart';
import 'package:flutter/material.dart';

class EcoGames extends StatelessWidget {
  final List<GridItem> items = [
    GridItem('Flashcards', Icons.quiz_outlined, const TopicPage(title: 'Flashcards')),
    GridItem('Quizzes', Icons.file_copy_outlined, const EcoQuiz()),
    GridItem('Trivia', Icons.emoji_events_outlined, const TopicPage(title: 'Trivia')),
  ];

  EcoGames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GridItemWidget(item: items[index]);
          },
        ),
      ),
    );
  }
}