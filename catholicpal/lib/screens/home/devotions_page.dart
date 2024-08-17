import 'package:catholicpal/screens/widgets/cards.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class DevotionsPage extends StatelessWidget {
  final List<CardWidget> devotions = [
    CardWidget(
      title: 'Rosary',
      color: Colors.blue[50]!,
      iconPath: 'assets/breviary-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Divine Mercy',
      color: Colors.red[50]!,
      iconPath: 'assets/breviary-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Stations of the Cross',
      color: Colors.green[50]!,
      iconPath: 'assets/prayer-svgrepo-com.svg',
    ),
    const CardWidget(
      title: 'Novenas',
      color: Color(0xFFF3E5F5),
      iconPath: 'assets/prayer-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Litanies',
      color: Colors.orange[50]!,
      iconPath: 'assets/breviary-svgrepo-com.svg',
    ),
    CardWidget(
      title: 'Adoration',
      color: Colors.yellow[50]!,
      iconPath: 'assets/prayer-beads-svgrepo-com.svg',
    ),
  ];

  DevotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Devotions',
        icon: Icons.favorite,
        iconColor: Colors.deepOrange,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: devotions.length,
        itemBuilder: (context, index) {
          final devotion = devotions[index];
          return CardWidget(
            title: devotion.title,
            color: devotion.color,
            iconPath: devotion.iconPath,
            onTap: () {
              // Handle card tap
            },
          );
        },
      ),
    );
  }
}
