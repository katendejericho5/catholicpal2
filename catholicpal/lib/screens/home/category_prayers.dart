import 'package:flutter/material.dart';

import 'package:catholicpal/screens/widgets/cards.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';

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
    CardWidget(
      title: 'Prayer 4',
      color: const Color(0xFFF3E5F5),
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
        // You can uncomment and use the icon if needed
        // icon: Icons.menu_book_rounded,
        // iconColor: Colors.deepOrange,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
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
            },
          );
        },
      ),
    );
  }
}
