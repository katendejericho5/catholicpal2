import 'package:catholicpal/screens/home/catholic_answers_page.dart';
import 'package:catholicpal/screens/home/daily_reading_page.dart';
import 'package:catholicpal/screens/home/news_screen.dart';
import 'package:catholicpal/screens/home/prayer_of_the_day_page.dart';
import 'package:catholicpal/screens/home/saint_of_the_day_page.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:catholicpal/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../data/sections_data.dart'; // Import the data
import '../../models/section.dart'; // Import the model

class UpdatesPage extends StatefulWidget {
  const UpdatesPage({super.key});

  @override
  State<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Initialize the ScrollController
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // Dispose the ScrollController
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Updates',
        scrollController: _scrollController,
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          controller: _scrollController, // Attach the ScrollController
          itemCount: sections.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8, // To give it a vertical feel
          ),
          itemBuilder: (context, index) {
            final Section section = sections[index];
            return customImageContainer(
              imageUrl: section.imageUrl,
              title: section.title,
              isFavorite: false, // Set your logic for favorites

              onFavoriteTap: () {
                // Handle favorite tap logic
              },

              onTap: () {
                // Handle image tap logic based on section title
                switch (section.title) {
                  case 'Daily Readings':
                    // Navigate to Daily Readings Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DailyReadingsPage(),
                      ),
                    );
                    break;
                  case 'Saint of the Day':
                    // Navigate to Saint of the Day Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SaintOfTheDayPage()),
                    );
                    break;
                  case 'Prayer of the Day':
                    // Navigate to Prayer of the Day Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrayerOfTheDayPage(),
                      ),
                    );
                    break;
                  case 'Daily News':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewsScreen(),
                      ),
                    );
                    break;
                  case 'Catholic Answers':
                    // Navigate to Resources Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CatholicAnswersNewsScreen(),
                      ),
                    );
                    break;
                  default:
                    // Handle default case
                    break;
                }
              },
              height: 200,
              showFavorite: false, // Optional height, adjust as needed
            );
          },
        ),
      ),
    );
  }
}
