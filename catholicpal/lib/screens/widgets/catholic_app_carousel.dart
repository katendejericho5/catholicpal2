import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class CatholicAppCarousel extends StatefulWidget {
  const CatholicAppCarousel({super.key});

  @override
  State<CatholicAppCarousel> createState() => _CatholicAppCarouselState();
}

class _CatholicAppCarouselState extends State<CatholicAppCarousel> {
  int _current = 0; // Current index for the carousel
  final CarouselController _controller = CarouselController();
  final List<Map<String, String>> _carouselItems = [
    {
      'title': 'Daily Prayer',
      'content': 'Lord, guide me through this day...',
      'imageUrl':
          'https://images.pexels.com/photos/2526517/pexels-photo-2526517.jpeg?auto=compress&cs=tinysrgb&w=800',
    },
    {
      'title': 'Saint of the Day',
      'content': 'St. Francis of Assisi',
      'imageUrl':
          'https://images.pexels.com/photos/2526517/pexels-photo-2526517.jpeg?auto=compress&cs=tinysrgb&w=800',
    },
    {
      'title': 'Today\'s Reading',
      'content': 'Matthew 5:1-12',
      'imageUrl':
          'https://images.pexels.com/photos/270640/pexels-photo-270640.jpeg?auto=compress&cs=tinysrgb&w=800',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              items: _carouselItems.map((item) {
                return _buildCarouselItem(
                  title: item['title']!,
                  content: item['content']!,
                  imageUrl: item['imageUrl']!,
                );
              }).toList(),
            ),
            Positioned(
              bottom: 16, // Position indicators above the bottom
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _carouselItems.asMap().entries.map((entry) {
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
                      ));
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem(
      {required String title,
      required String content,
      required String imageUrl}) {
    return Container(
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
                    fontSize: 18,
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
