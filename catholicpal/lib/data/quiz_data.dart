// lib/data/question_data.dart

import 'package:catholicpal/models/quiz/quiz_model.dart';

List<Question> getQuestions() {
  return [
    Question(
      id: '1',
      questionText: 'What is the capital of France?',
      options: ['London', 'Berlin', 'Paris', 'Madrid'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: '2',
      questionText: 'Who painted the Mona Lisa?',
      options: [
        'Vincent van Gogh',
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Michelangelo'
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: '3',
      questionText: 'What is the largest planet in our solar system?',
      options: ['Mars', 'Jupiter', 'Saturn', 'Neptune'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: '4',
      questionText: 'In which year did World War II end?',
      options: ['1943', '1944', '1945', '1946'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: '5',
      questionText: 'What is the chemical symbol for gold?',
      options: ['Go', 'Gd', 'Au', 'Ag'],
      correctAnswerIndex: 2,
    ),
    // Add more questions here...
  ];
}
