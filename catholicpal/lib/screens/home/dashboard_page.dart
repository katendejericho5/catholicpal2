import 'dart:async';
import 'package:catholicpal/screens/widgets/cached_image.dart';
import 'package:catholicpal/services/prayer_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:catholicpal/models/categories_model.dart';
import 'package:catholicpal/screens/home/category_prayers.dart';
import 'package:catholicpal/screens/home/saints_details_page.dart';
import 'package:catholicpal/screens/widgets/widgets.dart';
import 'package:catholicpal/screens/widgets/catholic_app_carousel.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<Category> categories = []; // Initialize an empty list for categories
  final DataService _dataService =
      DataService(); // Create an instance of DataService

  @override
  void initState() {
    super.initState();
    _loadCategories(); // Load categories when the widget is initialized
  }

  Future<void> _loadCategories() async {
    final fetchedCategories = await _dataService.loadCategories();
    setState(() {
      categories = fetchedCategories; // Update the categories state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting and Profile
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi John',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Good morning',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1583314965950-cd54a8b6db84?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww'),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const CatholicAppCarousel(),
            const SizedBox(height: 30),

            // Categories Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prayer Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the page
                  },
                  child: Container(
                    width: 40, // Adjusted width for the icon
                    height: 40, // Adjusted height for the icon
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight03,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Row of categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPrayersPage(
                            categoryId: category.id,
                            categoryName: category.name,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.only(right: 10),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ShimmerCachedImage(
                                imageUrl: category
                                    .imageUrl, // Use category.image assuming your Category model has this property
                                fit: BoxFit.cover,
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: Colors.black54,
                                child: Text(
                                  category
                                      .name, // Use category.title assuming your Category model has this property
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),

            // Saints Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saints',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the page
                  },
                  child: Container(
                    width: 40, // Adjusted width for the icon
                    height: 40, // Adjusted height for the icon
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight03,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Horizontal list of saints
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  saintContainer(
                    imageUrl:
                        'https://images.pexels.com/photos/2123307/pexels-photo-2123307.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Saint Peter',
                    isFavorite: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailsPage()),
                      );
                    },
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  saintContainer(
                    imageUrl:
                        'https://images.pexels.com/photos/10628580/pexels-photo-10628580.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Saint Paul',
                    isFavorite: true,
                    onTap: () {},
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  saintContainer(
                    imageUrl:
                        'https://images.pexels.com/photos/5418210/pexels-photo-5418210.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Saint Mary',
                    isFavorite: true,
                    onTap: () {},
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  saintContainer(
                    imageUrl:
                        'https://images.pexels.com/photos/3993922/pexels-photo-3993922.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Saint Francis',
                    isFavorite: true,
                    onTap: () {},
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Quizzes Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sacraments',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the page
                  },
                  child: Container(
                    width: 40, // Adjusted width for the icon
                    height: 40, // Adjusted height for the icon
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight03,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Horizontal list of quizzes
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  quizContainer(
                    onTap: () {},
                    imageUrl:
                        'https://images.pexels.com/photos/5687170/pexels-photo-5687170.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Quiz 1',
                    isFavorite: true,
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  quizContainer(
                    onTap: () {},
                    imageUrl:
                        'https://images.pexels.com/photos/5647609/pexels-photo-5647609.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Quiz 2',
                    isFavorite: true,
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  quizContainer(
                    onTap: () {},
                    imageUrl:
                        'https://images.pexels.com/photos/5647609/pexels-photo-5647609.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Quiz 3',
                    isFavorite: true,
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
