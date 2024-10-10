import 'package:catholicpal/screens/home/sacraments/baptism/baptism_catechism_page.dart';
import 'package:catholicpal/screens/home/sacraments/baptism/baptism_faq_page.dart';
import 'package:catholicpal/screens/home/sacraments/baptism/baptism_history_page.dart';
import 'package:catholicpal/screens/home/sacraments/baptism/baptism_quiz_page.dart';
import 'package:catholicpal/screens/home/sacraments/baptism/baptism_rite_page.dart';
import 'package:catholicpal/screens/home/sacraments/baptism/bible_quiz/quiz_questions.dart';
import 'package:flutter/material.dart';
import 'package:catholicpal/screens/widgets/cards.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BaptismPage extends StatefulWidget {
  const BaptismPage({super.key});

  @override
  State<BaptismPage> createState() => _BaptismPageState();
}

class _BaptismPageState extends State<BaptismPage> {
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
      const Color(0xffe0f7fa), // Light Cyan
      const Color(0xfff1f8e9), // Light Green
      const Color(0xfffce4ec), // Light Pink
      const Color(0xffede7f6), // Light Purple
      const Color(0xfffff3e0), // Light Orange
    ];
  }

  @override
  Widget build(BuildContext context) {
    final baptismItems = [
      {
        'title': 'History & Salvation',
        'iconPath': "assets/prayer-svgrepo-com (1).svg"
      },
      {
        'title': 'Baptism Rite',
        'iconPath': "assets/prayer-svgrepo-com (2).svg"
      },
      {'title': 'Quiz', 'iconPath': "assets/prayer-svgrepo-com (3).svg"},
      {'title': 'Catechism', 'iconPath': "assets/prayer-svgrepo-com.svg"},
      {
        'title': 'FAQ',
        'iconPath':
            "assets/prayer-at-altar-cross-religion-church-svgrepo-com.svg"
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Baptism',
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
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: baptismItems.length,
                itemBuilder: (context, index) {
                  final item = baptismItems[index];
                  Color color = _colors[index % _colors.length];
                  return CardWidget(
                    title: item['title']!,
                    color: color,
                    iconPath: item['iconPath']!,
                    onTap: () {
                      // Navigate to the corresponding page
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
      case 'History & Salvation':
        return const BaptismHistoryPage();
      case 'Baptism Rite':
        return BaptismRitePage();
      case 'Quiz':
        // return BaptismQuizPage();
        return const QuizPage();
      case 'Catechism':
        return BaptismCatechismPage();
      case 'FAQ':
        return BaptismFAQPage();
      default:
        return const Scaffold(body: Center(child: Text('Page not found')));
    }
  }
}
