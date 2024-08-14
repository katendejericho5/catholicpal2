import 'package:catholicpal/screens/home/bible_page.dart';
import 'package:catholicpal/screens/home/devotions_page.dart';
import 'package:catholicpal/screens/home/dashboard_page.dart';
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
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
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
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const ColorScheme.light().surface,
              selectedItemColor: const Color(0xFF3498DB),
              unselectedItemColor: const Color(0xFFBDC3C7),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.normal),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
