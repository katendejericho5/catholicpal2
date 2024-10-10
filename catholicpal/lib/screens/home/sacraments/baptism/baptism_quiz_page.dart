import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaptismQuizPage extends StatefulWidget {
  @override
  _BaptismQuizPageState createState() => _BaptismQuizPageState();
}

class _BaptismQuizPageState extends State<BaptismQuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the primary effect of Baptism?',
      'answers': [
        'Cleansing from original sin and all personal sins',
        'Receiving a new name',
        'Joining a specific parish',
        'Learning church teachings'
      ],
      'correctAnswer': 0,
    },
    {
      'question': 'Who can perform a Baptism?',
      'answers': [
        'Only a bishop',
        'Only a priest',
        'Any baptized person in case of necessity',
        'Only parents or godparents'
      ],
      'correctAnswer': 2,
    },
    // Add more questions here
  ];

  void answerQuestion(int selectedAnswer) {
    if (selectedAnswer == questions[currentQuestionIndex]['correctAnswer']) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      setState(() {
        quizCompleted = true;
      });
    }
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Baptism Quiz', style:  GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.blue[100]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: quizCompleted ? _buildResult() : _buildQuestion(),
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questions[currentQuestionIndex]['question'],
              style:  GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            ...(questions[currentQuestionIndex]['answers'] as List<String>)
                .asMap()
                .entries
                .map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => answerQuestion(entry.key),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue[700],
                    textStyle:  GoogleFonts.poppins(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(entry.value),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildResult() {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                'Quiz Completed!',
                style:  GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 20),
              Text(
                'Your Score: $score / ${questions.length}',
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetQuiz,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue[700],
                  textStyle:  GoogleFonts.poppins(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Retake Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
