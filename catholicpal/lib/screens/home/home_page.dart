import 'package:catholicpal/screens/home/bible_page.dart';
import 'package:catholicpal/screens/home/devotions_page.dart';
import 'package:catholicpal/screens/home/dashboard_page.dart';
import 'package:catholicpal/screens/home/settings_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    const SettingsPage(),
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
                  icon: FaIcon(FontAwesomeIcons.house, size: 20),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.bookOpen, size: 20),
                  label: 'Bible',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.heart, size: 20),
                  label: 'Devotions',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.cog, size: 20),
                  label: 'Settings',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const ColorScheme.light().surface,
              selectedItemColor: const Color(0xFF3498DB),
              unselectedItemColor: Colors.grey[600],
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
