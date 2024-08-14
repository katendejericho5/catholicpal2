import 'package:catholicpal/screens/home/bible_page.dart';
import 'package:catholicpal/screens/home/devotions_page.dart';
import 'package:catholicpal/screens/home/home_content.dart';
import 'package:catholicpal/screens/home/quizzes_page.dart';
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
