import 'package:catholicpal/screens/home/sacraments/baptism/bible_quiz/quiz_questions.dart';
import 'package:catholicpal/screens/home/sacraments/confession/penance_absolution_page.dart';
import 'package:catholicpal/screens/home/sacraments/confession/preparation_examination_page.dart';
import 'package:catholicpal/screens/home/sacraments/confession/rite_of_confession_page.dart';
import 'package:catholicpal/screens/home/sacraments/confession/spiritual_growth_page.dart';
import 'package:catholicpal/screens/home/sacraments/confession/understanding_reconciliation_page.dart';
import 'package:flutter/material.dart';
import 'package:catholicpal/screens/widgets/cards.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfessionPage extends StatefulWidget {
  const ConfessionPage({super.key});

  @override
  ConfessionPageState createState() => ConfessionPageState();
}

class ConfessionPageState extends State<ConfessionPage> {
  late ScrollController _scrollController;
  late List<Color> _colors;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _colors = _generateSpiritualColors();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Color> _generateSpiritualColors() {
    return [
      const Color(0xFFE3F2FD), // Light Blue (Divine Mercy)
      const Color(0xFFFFF3E0), // Light Orange (Penance)
      const Color(0xFFE8F5E9), // Light Green (Hope)
      const Color(0xFFFCE4EC), // Light Pink (God's Love)
      const Color(0xFFF3E5F5), // Light Purple (Repentance)
      const Color(0xFFFFFDE7), // Light Yellow (New Beginning)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final confessionItems = [
      {
        'title': 'Reconciliation',
        'iconPath':             "assets/prayer-at-altar-cross-religion-church-svgrepo-com.svg"

      },
      {
        'title': 'Preparation',
        'iconPath': "assets/prayer-svgrepo-com (3).svg"
      },
      {
        'title': 'Confession Rite',
        'iconPath': "assets/prayer-svgrepo-com (2).svg"
      },
      {
        'title': 'Penance',
        'iconPath': "assets/prayer-svgrepo-com (1).svg"
      },
      {
        'title': 'Quiz',
        'iconPath': "assets/prayer-svgrepo-com (1).svg"
      },
      {
        'title': 'Growth',
        'iconPath': "assets/prayer-svgrepo-com (2).svg"
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reconciliation',
        scrollController: _scrollController,
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12),
                  child: FaIcon(
                    FontAwesomeIcons.search,
                    size: 20,
                  ),
                ),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 14,
                ),
                itemCount: confessionItems.length,
                itemBuilder: (context, index) {
                  final item = confessionItems[index];
                  Color color = _colors[index % _colors.length];
                  return CardWidget(
                    title: item['title']!,
                    color: color,
                    iconPath: item['iconPath']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => _getPage(item['title']!),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPage(String title) {
    switch (title) {
      case 'Reconciliation':
        return const UnderstandingReconciliationPage();
      case 'Preparation':
        return const PreparationExaminationPage();
      case 'Confession Rite':
        return const RiteOfConfessionPage();
      case 'Penance':
        return const PenanceAbsolutionPage();
      case 'Quiz':
        return const QuizPage();
      case 'Growth':
        return const SpiritualGrowthPage();
      default:
        return const Scaffold(body: Center(child: Text('Page not found')));
    }
  }
}
