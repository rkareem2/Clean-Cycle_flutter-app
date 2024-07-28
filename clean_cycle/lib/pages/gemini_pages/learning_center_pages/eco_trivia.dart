import 'package:clean_cycle/components/chatbot.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class GeminiApi {
  final String apiKey = geminiApiKey();

  Future<List<Question>> fetchQuestions() async {
    String request = 'Generate eco-friendly trivia questions with multiple-choice answers and provide the answers all in json format.';
    final responseText = await queryGemini(request);

    if (responseText != null) {
      List<dynamic> data = jsonDecode(
        responseText.replaceAll("\n", "").replaceAll("```json{  ", "").replaceAll("\"questions\":", "").replaceAll("}```", "").replaceAll("    ", "").replaceAll("```json", "").replaceAll("```", "")
      );
      return data.map((question) => Question.fromJson(question)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({required this.question, required this.options, required this.correctAnswer});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['answer'],
    );
  }
}

class QuizProvider with ChangeNotifier {
  final GeminiApi _geminiApi = GeminiApi();
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;

  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;

  Future<void> loadQuestions() async {
    _questions = await _geminiApi.fetchQuestions();
    _currentIndex = 0;
    _score = 0;
    notifyListeners();
  }

  void answerQuestion(String answer) {
    if (_questions[_currentIndex].correctAnswer == answer) {
      _score++;
    }
    _currentIndex++;
    notifyListeners();
  }
}

class EcoTrivia extends StatefulWidget {
  const EcoTrivia({super.key});

  @override
  _EcoTriviaState createState() => _EcoTriviaState();
}

class _EcoTriviaState extends State<EcoTrivia> {
  List<Question> _questions = [];
  bool _isLoading = true;
  String? _errorMessage;
  final Map<int, String> _selectedAnswers = {};
  bool _submitted = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      List<Question> questions = await GeminiApi().fetchQuestions();
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  void _submitQuiz() {
    setState(() {
      _submitted = true;
      _score = 0;
      for (int i = 0; i < _questions.length; i++) {
        if (_selectedAnswers[i] == _questions[i].correctAnswer) {
          _score++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Trivia'),
      ),
      body: _submitted ? _buildResultPage() : _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage'))
              :  _buildQuizPage(),
    );
  }

  Widget _buildQuizPage() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _questions.length,
            itemBuilder: (context, index) {
              return _buildQuestion(_questions[index], index);
            },
          )
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitQuiz,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
          child: const Text('Submit Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildQuestion(Question question, int index) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: question.options.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _selectedAnswers[index],
                  onChanged: (value) {
                    setState(() {
                      _selectedAnswers[index] = value!;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultPage() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Your Score: $_score/${_questions.length}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        ..._questions.asMap().entries.map((entry) {
          int index = entry.key;
          Question question = entry.value;
          bool correct = _selectedAnswers[index] == question.correctAnswer;
          return ListTile(
            title: Text(question.question),
            subtitle: Text('Your answer: ${_selectedAnswers[index]}'),
            trailing: Icon(
              correct ? Icons.check : Icons.close,
              color: correct ? Colors.green : Colors.red,
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _submitted = false;
                _selectedAnswers.clear();
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
            child: const Text('Restart Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
