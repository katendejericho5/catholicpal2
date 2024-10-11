import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure you have the flutter_svg package in your pubspec.yaml

class CategorySelectionPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {
      'name': 'Youth',
      'icon': 'assets/prayer-at-altar-cross-religion-church-svgrepo-com.svg'
    },
    {'name': 'Children', 'icon': 'assets/icon-children.svg'},
    {'name': 'Unmarried', 'icon': 'assets/icon-unmarried.svg'},
    {'name': 'Married', 'icon': 'assets/icon-married.svg'},
  ];

  CategorySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examination of Conscience'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Display 2 cards per row
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categories[index]['name']!,
              iconPath: categories[index]['icon']!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QuestionsPage(category: categories[index]['name']!),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final String iconPath;
  final VoidCallback onTap;

  const CategoryCard(
      {super.key,
      required this.category,
      required this.iconPath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        color: Colors.lightGreen[100], // Custom card color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 50, // Adjust icon size as needed
            ),
            const SizedBox(height: 8),
            Text(
              category,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionsPage extends StatelessWidget {
  final String category;

  QuestionsPage({super.key, required this.category});

  final Map<String, List<String>> questionsByCategory = {
    'Children': [
      'Have I respected my parents and elders?',
      'Have I told the truth, even when it was difficult?',
      'Have I been kind to my siblings or classmates?',
    ],
    'Youth': [
      'Have I stayed faithful to my commitments?',
      'Have I avoided harmful gossip or rumors?',
    ],
    'Unmarried': [
      'Have I maintained purity in my thoughts and actions?',
      'Have I respected the dignity of others in my relationships?',
    ],
    'Married': [
      'Have I nurtured my relationship with my spouse?',
      'Have I been patient and understanding in family conflicts?',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final questions = questionsByCategory[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Examination'),
        backgroundColor: Colors.teal, // Custom AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Display 2 questions per row
            childAspectRatio: 1, // Adjust this based on your design
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return QuestionCard(
              question: questions[index],
            );
          },
        ),
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  final String question;

  const QuestionCard({super.key, required this.question});

  @override
  QuestionCardState createState() => QuestionCardState();
}

class QuestionCardState extends State<QuestionCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.blue[100], // Custom question card color
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.question,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
