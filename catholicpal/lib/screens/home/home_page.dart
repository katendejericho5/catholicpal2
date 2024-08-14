import 'package:catholicpal/screens/bible/bible_home_page.dart';
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
    const BibleHomePage(),
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
              items: [
                _buildBottomNavigationBarItem(
                  icon: FontAwesomeIcons.house,
                  label: 'Home',
                  index: 0,
                ),
                _buildBottomNavigationBarItem(
                  icon: FontAwesomeIcons.bookOpen,
                  label: 'Bible',
                  index: 1,
                ),
                _buildBottomNavigationBarItem(
                  icon: FontAwesomeIcons.heart,
                  label: 'Devotions',
                  index: 2,
                ),
                _buildBottomNavigationBarItem(
                  icon: FontAwesomeIcons.cog,
                  label: 'Settings',
                  index: 3,
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

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.lightGreenAccent.withOpacity(0.3) : Colors.transparent,
        ),
        child: FaIcon(
          icon,
          size: 20,
          color: isSelected ? const Color(0xFF27AE60) : Colors.grey[600],
        ),
      ),
      label: label,
    );
  }
}
