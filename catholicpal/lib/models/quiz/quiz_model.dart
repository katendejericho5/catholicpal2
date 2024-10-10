// lib/model/question.dart
class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}