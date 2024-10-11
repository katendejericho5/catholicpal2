import 'package:catholicpal/models/quiz/quiz_model.dart';

List<Question> getQuestions() {
  return [
    Question(
      id: '1',
      questionText: 'What is the first sacrament of initiation in the Catholic Church?',
      options: ['Baptism', 'Eucharist', 'Confirmation', 'Reconciliation'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: '2',
      questionText: 'Which symbol is primarily used in the Sacrament of Baptism?',
      options: ['Oil', 'Water', 'Fire', 'Bread'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: '3',
      questionText: 'Baptism removes the stain of what?',
      options: ['Venial sin', 'Original sin', 'Personal sin', 'All sin'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: '4',
      questionText: 'Which prayer is recited during a Catholic Baptism?',
      options: ['Nicene Creed', 'Apostles’ Creed', 'Our Father', 'Hail Mary'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: '5',
      questionText: 'Who can administer the Sacrament of Baptism in case of an emergency?',
      options: ['Only a priest', 'Only a deacon', 'Anyone', 'Only a bishop'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: '6',
      questionText: 'What are the two main effects of Baptism?',
      options: [
        'Forgiveness of sin and becoming a member of the Church',
        'Eternal life and receiving the Holy Spirit',
        'Becoming a priest and eternal salvation',
        'Forgiveness of all sins and receiving communion'
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: '7',
      questionText: 'What do godparents pledge to do during a Baptism?',
      options: [
        'Pray for the baptized and help them grow in the faith',
        'Financially support the child',
        'Lead the child\'s education',
        'Guide the child in career choices'
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: '8',
      questionText: 'In which part of the Bible is Jesus baptized by John?',
      options: ['Matthew', 'Mark', 'Luke', 'John'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: '9',
      questionText: 'Which form of Baptism involves pouring water on the person’s head?',
      options: ['Immersion', 'Aspersion', 'Affusion', 'Submersion'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: '10',
      questionText: 'Baptism is a requirement for entry into which of the following?',
      options: ['Heaven', 'Priesthood', 'Church membership', 'Christian life'],
      correctAnswerIndex: 3,
    ),
    Question(
      id: '11',
      questionText: 'What is the Trinitarian formula used in Baptism?',
      options: [
        'In the name of Jesus Christ',
        'In the name of the Father, the Son, and the Holy Spirit',
        'In the name of the Church',
        'In the name of Mary and the Saints'
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: '12',
      questionText: 'Which Church council reaffirmed the necessity of Baptism for salvation?',
      options: [
        'Council of Trent',
        'First Vatican Council',
        'Council of Nicaea',
        'Second Vatican Council'
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: '13',
      questionText: 'What do the white garment and candle symbolize in Baptism?',
      options: [
        'Victory over sin and eternal life',
        'Purity and the light of Christ',
        'Salvation and resurrection',
        'Faith and hope'
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: '14',
      questionText: 'What does Baptism signify spiritually?',
      options: [
        'Entering into Christ’s death and resurrection',
        'Becoming an ordained minister',
        'Completion of faith',
        'Purification of the body'
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: '15',
      questionText: 'Which oil is used in the anointing during Baptism?',
      options: [
        'Chrism oil',
        'Olive oil',
        'Oil of catechumens',
        'Oil of salvation'
      ],
      correctAnswerIndex: 2,
    ),
    // Add more questions here if needed...
  ];
}
