import 'package:catholicpal/screens/home/all_prayers_page.dart';
import 'package:catholicpal/screens/home/details_page.dart';
import 'package:catholicpal/screens/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

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
                    const Text(
                      'Hi John',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Good morning',
                      style: TextStyle(
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

            // Search bar
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

            // Prayers Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Prayers',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllPrayersPage()),
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Horizontal list of prayers
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  prayerContainer(
                    imageUrl:
                        'https://images.pexels.com/photos/1615776/pexels-photo-1615776.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Morning Prayer',
                    onTap: () {},
                    isFavorite: true,
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  prayerContainer(
                    imageUrl:
                        'https://images.pexels.com/photos/2774546/pexels-photo-2774546.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Evening Prayer',
                    isFavorite: true,
                    onTap: () {},
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  prayerContainer(
                    imageUrl:
                        'https://images.pexels.com/photos/267748/pexels-photo-267748.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Night Prayer',
                    isFavorite: true,
                    onTap: () {},
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  prayerContainer(
                    imageUrl:
                        'https://images.pexels.com/photos/208216/pexels-photo-208216.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Noon Prayer',
                    isFavorite: true,
                    onTap: () {},
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  prayerContainer(
                    imageUrl:
                        'https://images.pexels.com/photos/2356140/pexels-photo-2356140.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Thanksgiving Prayer',
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

            // Saints Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Saints',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to Saints page
                  },
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
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
                const Text(
                  'Quizzes',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to Quizzes page
                  },
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
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
                        'https://images.pexels.com/photos/4607986/pexels-photo-4607986.jpeg?auto=compress&cs=tinysrgb&w=600',
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
                        'https://images.pexels.com/photos/7092344/pexels-photo-7092344.jpeg?auto=compress&cs=tinysrgb&w=600',
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
                        'https://images.pexels.com/photos/6839189/pexels-photo-6839189.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Quiz 3',
                    isFavorite: true,
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                  const SizedBox(width: 10),
                  quizContainer(
                    onTap: () {},
                    imageUrl:
                        'https://images.pexels.com/photos/3565151/pexels-photo-3565151.jpeg?auto=compress&cs=tinysrgb&w=600',
                    title: 'Quiz 4',
                    isFavorite: true,
                    onFavoriteTap: () {
                      // Handle favorite tap
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
