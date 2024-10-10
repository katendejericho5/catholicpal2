// lib/provider/quiz_provider.dart
import 'package:catholicpal/data/quiz_data.dart';
import 'package:catholicpal/models/quiz/quiz_model.dart';
import 'package:flutter/foundation.dart';

class QuizProvider with ChangeNotifier {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  bool _lastAnswerCorrect = false;
  int? _userAnswer;

  QuizProvider() {
    _loadQuestions();
  }

  void _loadQuestions() {
    _questions = getQuestions();
    notifyListeners();
  }

  Question get currentQuestion => _questions[_currentQuestionIndex];
  int get currentQuestionIndex => _currentQuestionIndex;
  int get totalQuestions => _questions.length;
  int get score => _score;
  bool get answered => _answered;
  bool get lastAnswerCorrect => _lastAnswerCorrect;
  int? get userAnswer => _userAnswer;

  double get progress => (_currentQuestionIndex + 1) / totalQuestions; // Progress calculation

  void answerQuestion(int selectedAnswerIndex) {
    if (_answered) return; // Prevent answering twice

    _answered = true;
    _userAnswer = selectedAnswerIndex;
    _lastAnswerCorrect =
        selectedAnswerIndex == currentQuestion.correctAnswerIndex;

    if (_lastAnswerCorrect) {
      _score++;
    }

    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _answered = false;
      _userAnswer = null;
    }
    notifyListeners();
  }

  bool get isQuizFinished =>
      _currentQuestionIndex >= _questions.length - 1 && _answered;

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _answered = false;
    _userAnswer = null;
    notifyListeners();
  }
}
