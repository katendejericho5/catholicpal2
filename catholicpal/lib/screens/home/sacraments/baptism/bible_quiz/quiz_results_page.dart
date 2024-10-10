// lib/ui/result_page.dart
import 'package:catholicpal/providers/quiz_provider.dart';
import 'package:catholicpal/screens/home/sacraments/baptism/bible_quiz/quiz_questions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Score: ${quizProvider.score}/${quizProvider.totalQuestions}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text('Restart Quiz'),
              onPressed: () {
                quizProvider.resetQuiz();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}