import 'package:catholicpal/providers/quiz_provider.dart';
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
    final theme = Theme.of(context); // Accessing the theme
    double scorePercentage = quizProvider.score / quizProvider.totalQuestions;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Quiz Results',
        scrollController: _scrollController,
        actions: const [],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    color: scorePercentage > 0.6
                        ? theme.colorScheme.primary
                        : theme.colorScheme
                            .error, // Theme colors based on performance
                  ),
                ),
                progressColor: scorePercentage > 0.6
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
                backgroundColor: theme.colorScheme.onSurface.withOpacity(0.2),
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                animationDuration: 1200,
              ),
              const SizedBox(height: 40),

              // "Quiz Completed" Text
              Text(
                'Quiz Completed!',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme
                      .textTheme.titleLarge!.color, // Using theme's text color
                ),
              ),
              const SizedBox(height: 20),

              // Display Final Score
              Text(
                'Your Score: ${quizProvider.score}/${quizProvider.totalQuestions}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: theme
                      .textTheme.bodyLarge!.color, // Body text color from theme
                ),
              ),
              const SizedBox(height: 30),

              // Restart Button with Icon
              ElevatedButton.icon(
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },
                icon: const Icon(Icons.restart_alt), // Icon for the restart
                label: Text(
                  'Restart Quiz',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimary, // Text color on button
                  ),
                  backgroundColor:
                      theme.colorScheme.primary, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Option to go back to home or other sections
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Navigates back to the home page
                },
                child: Text(
                  'Back to Home',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: theme
                        .colorScheme.primary, // Primary color for back button
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
