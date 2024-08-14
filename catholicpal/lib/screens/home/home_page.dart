import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of widget pages
  final List<Widget> _pages = [
    const HomeContent(),
    const BiblePage(),
    const DevotionsPage(),
    const QuizzesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: -10,
      ),
      body: _pages[_selectedIndex], // Display selected page content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bible',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Devotions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quizzes',
          ),
        ],
        selectedItemColor: Colors.blue, // Optionally customize color
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Sample home content
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                prayerContainer(
                  imageUrl:
                      'https://images.pexels.com/photos/1615776/pexels-photo-1615776.jpeg?auto=compress&cs=tinysrgb&w=600',
                  title: 'Morning Prayer',
                ),
                const SizedBox(width: 10),
                prayerContainer(
                  imageUrl:
                      'https://images.pexels.com/photos/2774546/pexels-photo-2774546.jpeg?auto=compress&cs=tinysrgb&w=600',
                  title: 'Evening Prayer',
                ),
                const SizedBox(width: 10),
                prayerContainer(
                  imageUrl:
                      'https://images.pexels.com/photos/267748/pexels-photo-267748.jpeg?auto=compress&cs=tinysrgb&w=600',
                  title: 'Night Prayer',
                ),
                const SizedBox(width: 10),
                prayerContainer(
                  imageUrl:
                      'https://images.pexels.com/photos/208216/pexels-photo-208216.jpeg?auto=compress&cs=tinysrgb&w=600',
                  title: 'Noon Prayer',
                ),
                const SizedBox(width: 10),
                prayerContainer(
                  imageUrl:
                      'https://images.pexels.com/photos/2356140/pexels-photo-2356140.jpeg?auto=compress&cs=tinysrgb&w=600',
                  title: 'Thanksgiving Prayer',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget prayerContainer({required String imageUrl, required String title}) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 150,
          height: 50,
          decoration: const BoxDecoration(
            color: Color.fromARGB(38, 238, 238, 238),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Sample "AllPrayersPage"
class AllPrayersPage extends StatelessWidget {
  const AllPrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Prayers'),
      ),
      body: const Center(
        child: Text('All prayers will be listed here.'),
      ),
    );
  }
}

// Sample Bible Page
class BiblePage extends StatelessWidget {
  const BiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Bible content goes here.'),
    );
  }
}

// Sample Devotions Page
class DevotionsPage extends StatelessWidget {
  const DevotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Devotions content goes here.'),
    );
  }
}

// Sample Quizzes Page
class QuizzesPage extends StatelessWidget {
  const QuizzesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Quizzes content goes here.'),
    );
  }
}
