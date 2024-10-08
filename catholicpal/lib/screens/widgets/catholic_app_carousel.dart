import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/providers/daily_reading_provider.dart';
import 'package:catholicpal/providers/prayer_of_the_day_provider.dart';
import 'package:catholicpal/providers/saint_of_the_day_provider.dart';
import 'package:catholicpal/screens/home/daily_reading_page.dart';
import 'package:catholicpal/screens/home/prayer_of_the_day_page.dart';
import 'package:catholicpal/screens/home/saint_of_the_day_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CatholicAppCarousel extends StatefulWidget {
  const CatholicAppCarousel({super.key});

  @override
  State<CatholicAppCarousel> createState() => _CatholicAppCarouselState();
}

class _CatholicAppCarouselState extends State<CatholicAppCarousel> {
  int _current = 0; // Current index for the carousel
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    // Fetch data from providers
    final dailyReading = context.watch<DailyReadingProvider>().currentReading;
    final prayerOfTheDay =
        context.watch<PrayerOfTheDayProvider>().prayerOfTheDay;
    final saintOfTheDay = context.watch<SaintOfTheDayProvider>().saint;

    // Prepare carousel items
    final List<Map<String, dynamic>> carouselItems = [
      {
        'title': 'Daily Prayer',
        'content': prayerOfTheDay?.title ?? 'No prayer available',
        'imageUrl':
            'https://images.pexels.com/photos/10295200/pexels-photo-10295200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'navigateTo': const PrayerOfTheDayPage(),
      },
      {
        'title': 'Saint of the Day',
        'content': saintOfTheDay?.title ?? 'No saint information available',
        'imageUrl':
            'https://images.pexels.com/photos/19474817/pexels-photo-19474817/free-photo-of-traditional-painting-in-a-church-in-italy.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'navigateTo': const SaintOfTheDayPage(),
      },
      {
        'title': 'Today\'s Reading',
        'content': dailyReading?.title ?? 'No reading available',
        'imageUrl':
            'https://images.pexels.com/photos/9589497/pexels-photo-9589497.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'navigateTo': const DailyReadingsPage(),
      },
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200, // Fixed height for the carousel
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index; // Update current index
                  });
                },
                autoPlay: true,
              ),
              items: carouselItems.map((item) {
                return _buildCarouselItem(
                  title: item['title']!,
                  content: item['content']!,
                  imageUrl: item['imageUrl']!,
                  navigateTo: item['navigateTo']!, // Pass navigation target
                );
              }).toList(),
            ),
            Positioned(
              bottom: 16, // Position indicators above the bottom
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: carouselItems.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      _controller.animateTo(
                        entry.key.toDouble(), // Convert int to double
                        duration: const Duration(
                            milliseconds: 300), // Required duration
                        curve: Curves.easeInOut, // Required curve
                      );
                    },
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: entry.key == _current
                            ? Colors.green // Color for the active indicator
                            : Colors.white.withOpacity(
                                0.7), // Color for inactive indicators
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem({
    required String title,
    required String content,
    required String imageUrl,
    required Widget navigateTo, // Include the navigation target
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(
                    0.5), // Slightly lighter for better text visibility
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    content,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
