import 'dart:async';
import 'package:catholicpal/screens/home/calender_page.dart';
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
import 'package:provider/provider.dart';
import 'package:catholicpal/models/saints_model.dart';
import 'package:catholicpal/providers/saints_provider.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<Category> categories = [];
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SaintsProvider>(context, listen: false).loadSaints();
    });
  }

  Future<void> _loadCategories() async {
    final fetchedCategories = await _dataService.loadCategories();
    setState(() {
      categories = fetchedCategories;
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
                    width: 40,
                    height: 40,
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
                                imageUrl: category.imageUrl,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: Colors.black54,
                                child: Text(
                                  category.name,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LiturgicalCalendarScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
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
            SizedBox(
              height: 150,
              child: Consumer<SaintsProvider>(
                builder: (context, saintsProvider, child) {
                  if (saintsProvider.saints.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: saintsProvider.saints.length,
                    itemBuilder: (context, index) {
                      final saint = saintsProvider.saints[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SaintsDetailsPage(saint: saint),
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
                                    imageUrl: saint.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    color: Colors.black54,
                                    child: Text(
                                      saint.name,
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
                    },
                  );
                },
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
                    width: 40,
                    height: 40,
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
