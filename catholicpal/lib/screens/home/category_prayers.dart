import 'package:catholicpal/screens/home/prayer_details.dart';
import 'package:flutter/material.dart';
import 'package:catholicpal/screens/widgets/cards.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryPrayersPage extends StatelessWidget {
  final String category;

  // Example prayers for demonstration, replace with actual data
  final List<CardWidget> prayers = [
    CardWidget(
      title: 'Prayer 1',
      color: Colors.blue[50]!,
      iconPath: 'assets/maghrib-prayer-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Prayer 2',
      color: Colors.red[50]!,
      iconPath: 'assets/prayer-beads-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Prayer 3',
      color: Colors.green[50]!,
      iconPath: 'assets/prayer-svgrepo-com.svg',
    ),
    const CardWidget(
      title: 'Prayer 4',
      color: Color(0xFFF3E5F5),
      iconPath: 'assets/catholic-christian-church-svgrepo-com.svg',
    ),
    // Add more prayers as needed
  ];

  CategoryPrayersPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '$category Prayers',
        // Uncomment and use the icon if needed
        // icon: Icons.menu_book_rounded,
        // iconColor: Colors.deepOrange,
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
                  childAspectRatio: 1.4, // Adjust height of the cards
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: prayers.length,
                itemBuilder: (context, index) {
                  final prayer = prayers[index];
                  return CardWidget(
                    title: prayer.title,
                    color: prayer.color,
                    iconPath: prayer.iconPath,
                    onTap: () {
                      // Handle prayer card tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrayerDetailsPage(),
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
}
