import 'package:catholicpal/screens/widgets/cards.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class AllPrayersPage extends StatelessWidget {
  final List<CardWidget> prayers = [
    CardWidget(
      title: 'Our Father',
      color: Colors.blue[50]!,
      iconPath: 'assets/prayer-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Hail Mary',
      color: Colors.red[50]!,
      iconPath: 'assets/prayer-beads-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Glory Be',
      color: Colors.green[50]!,
      iconPath: 'assets/prayer-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Apostles’ Creed',
      color: const Color(0xFFF3E5F5),
      iconPath: 'assets/breviary-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Nicene Creed',
      color: Colors.orange[50]!,
      iconPath: 'assets/prayer-beads-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Hail Holy Queen',
      color: Colors.yellow[50]!,
      iconPath: 'assets/prayer-svgrepo-com.svg',
    ),
    // Add more prayers as needed
  ];

  AllPrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'All Prayers',
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
