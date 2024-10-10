import 'package:catholicpal/providers/quiz_provider.dart';
import 'package:catholicpal/screens/home/sacraments/baptism/bible_quiz/quiz_results_page.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Quiz',
            scrollController: _scrollController,
            actions: const [],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              16.0,
              0.0,
              16.0,
              80.0,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildQuestionIndicator(quizProvider),
                    const SizedBox(height: 20),
                    _buildQuestionText(quizProvider),
                    const SizedBox(height: 20),
                    _buildOptions(quizProvider),
                    const SizedBox(height: 20),
                    if (quizProvider.answered)
                      _buildAnswerFeedback(quizProvider),
                    const SizedBox(height: 20),
                    _buildNextButton(context, quizProvider),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionIndicator(QuizProvider quizProvider) {
    return Text(
      'Question ${quizProvider.currentQuestionIndex + 1}/${quizProvider.totalQuestions}',
      textAlign: TextAlign.left,
      style: GoogleFonts.poppins(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildQuestionText(QuizProvider quizProvider) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Text(
        quizProvider.currentQuestion.questionText,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOptions(QuizProvider quizProvider) {
    return Column(
      children: quizProvider.currentQuestion.options.asMap().entries.map(
        (entry) {
          int index = entry.key;
          String option = entry.value;
          bool isCorrect =
              index == quizProvider.currentQuestion.correctAnswerIndex;
          bool isSelected = index == quizProvider.userAnswer;

          Color getButtonColor() {
            if (!quizProvider.answered) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            if (isCorrect) return Colors.green;
            if (isSelected && !isCorrect) return Colors.red;
            return Colors.grey.shade400;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: quizProvider.answered
                    ? null
                    : () => quizProvider.answerQuestion(index),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: getButtonColor(),
                  disabledBackgroundColor: getButtonColor(),
                ),
                child: Text(
                  option,
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    color: quizProvider.answered && !isSelected && !isCorrect
                        ? Colors.grey.shade600
                        : Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildAnswerFeedback(QuizProvider quizProvider) {
    return Column(
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: 1.0,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: quizProvider.lastAnswerCorrect
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  quizProvider.lastAnswerCorrect ? Icons.check : Icons.close,
                  color: quizProvider.lastAnswerCorrect
                      ? Colors.green
                      : Colors.red,
                  size: 32.0,
                ),
                const SizedBox(width: 8),
                Text(
                  quizProvider.lastAnswerCorrect ? 'Correct!' : 'Wrong!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: quizProvider.lastAnswerCorrect
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!quizProvider.lastAnswerCorrect)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: 1.0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'The correct answer is: ${quizProvider.currentQuestion.options[quizProvider.currentQuestion.correctAnswerIndex]}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNextButton(BuildContext context, QuizProvider quizProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: quizProvider.userAnswer == null
              ? Colors.grey // Disable the button when no answer is selected
              : Theme.of(context).colorScheme.secondary, // Enable the button
        ),
        onPressed: quizProvider.userAnswer == null
            ? null // Disable the button when no answer is selected
            : () {
                if (quizProvider.isQuizFinished) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ResultPage(),
                    ),
                  );
                } else {
                  quizProvider.nextQuestion();
                  _animateToNextQuestion();
                }
              },
        child: Text(
          quizProvider.isQuizFinished ? 'See Results' : 'Next Question',
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _animateToNextQuestion() {
    // You can add any animations or transitions here if needed
  }
}
