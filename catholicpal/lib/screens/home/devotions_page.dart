import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DevotionsPage extends StatelessWidget {
  final List<DevotionCard> devotions = [
    DevotionCard(
      title: 'Rosary',
      color: Colors.blue[50]!,
      iconPath: 'assets/breviary-svgrepo-com.svg',
    ),
    DevotionCard(
      title: 'Divine Mercy',
      color: Colors.red[50]!,
      iconPath: 'assets/breviary-svgrepo-com.svg',
    ),
    DevotionCard(
      title: 'Stations of the Cross',
      color: Colors.green[50]!,
      iconPath: 'assets/prayer-svgrepo-com.svg',
    ),
    DevotionCard(
      title: 'Novenas',
      color: const Color(0xFFF3E5F5),
      iconPath: 'assets/prayer-svgrepo-com.svg',
    ),
    DevotionCard(
      title: 'Litanies',
      color: Colors.orange[50]!,
      iconPath: 'assets/breviary-svgrepo-com.svg',
    ),
    DevotionCard(
      title: 'Adoration',
      color: Colors.yellow[50]!,
      iconPath: 'assets/prayer-beads-svgrepo-com.svg',
    ),
    // Add more devotions as needed
  ];

  DevotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devotions'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4, // Slightly adjust height
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: devotions.length,
        itemBuilder: (context, index) {
          return DevotionCardWidget(devotion: devotions[index]);
        },
      ),
    );
  }
}

class DevotionCard {
  final String title;
  final Color color;
  final String iconPath;

  DevotionCard({
    required this.title,
    required this.color,
    required this.iconPath,
  });
}

class DevotionCardWidget extends StatelessWidget {
  final DevotionCard devotion;

  const DevotionCardWidget({super.key, required this.devotion});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: devotion.color,
      child: InkWell(
        onTap: () {
          // Handle card tap
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Increased padding for better spacing
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  devotion.title,
                  style: const TextStyle(
                    fontSize: 20, // Increased font size for better readability
                    fontWeight: FontWeight.w600, // Increased font weight
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                flex: 2,
                child: Opacity(
                  opacity: 0.2,
                  child: SvgPicture.asset(
                    devotion.iconPath,
                    fit: BoxFit.contain, // Ensures the SVG fits within its space
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
