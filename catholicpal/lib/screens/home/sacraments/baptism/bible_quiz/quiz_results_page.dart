import 'package:catholicpal/providers/quiz_provider.dart';
import 'package:catholicpal/screens/home/home_page.dart';
import 'package:catholicpal/screens/home/sacraments/baptism/bible_quiz/quiz_questions.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
    final quizProvider = Provider.of<QuizProvider>(context);
    final theme = Theme.of(context);
    double scorePercentage = quizProvider.score / quizProvider.totalQuestions;

    // Define progress color logic
    Color getProgressColor() {
      if (scorePercentage > 0.6) {
        return Colors.greenAccent; // High score
      } else if (scorePercentage >= 0.4) {
        return Colors.amber; // Average score
      } else {
        return Colors.redAccent; // Low score
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Quiz Results',
        scrollController: _scrollController,
        actions: const [], // Removed back button actions
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 10,
              shadowColor: Colors.black45,
              color: theme.colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Circular Score Indicator
                    CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 15.0,
                      percent: scorePercentage,
                      center: Text(
                        '${(scorePercentage * 100).toStringAsFixed(0)}%',
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: getProgressColor(), // Feedback color
                        ),
                      ),
                      progressColor: getProgressColor(),
                      backgroundColor:
                          theme.colorScheme.onSurface.withOpacity(0.2),
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animationDuration: 1200,
                    ),
                    const SizedBox(height: 40),

                    // "Quiz Completed" Text
                    Text(
                      'Quiz Completed!',
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Display Final Score
                    Text(
                      'Your Score: ${quizProvider.score}/${quizProvider.totalQuestions}',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Restart Quiz and Back to Home in the same row
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Restart Button with Icon
                        ElevatedButton.icon(
                          onPressed: () {
                            quizProvider.resetQuiz();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const QuizPage()),
                            );
                          },
                          // HomePage
                          icon: const Icon(Icons.restart_alt), // Restart icon
                          label: Text(
                            'Restart Quiz',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),

                        // Back to Home Button
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                            quizProvider.resetQuiz();
                          },
                          child: Text(
                            'Back to Home',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
