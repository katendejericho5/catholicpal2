import 'package:catholicpal/screens/home/devotions_page.dart';
import 'package:catholicpal/screens/home/dashboard_page.dart';
import 'package:catholicpal/screens/settings/settings_page.dart';
import 'package:catholicpal/screens/home/updates_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

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
    const UpdatesPage(),
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
        padding: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
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
                  icon: HugeIcons.strokeRoundedHome03,
                  label: 'Home',
                  index: 0,
                ),
                _buildBottomNavigationBarItem(
                  icon: HugeIcons.strokeRoundedWorkUpdate,
                  label: 'Updates',
                  index: 1,
                ),
                _buildBottomNavigationBarItem(
                  icon: HugeIcons.strokeRoundedUserGroup,
                  label: 'Devotions',
                  index: 2,
                ),
                _buildBottomNavigationBarItem(
                  icon: HugeIcons.strokeRoundedUserSettings01,
                  label: 'Settings',
                  index: 3,
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey[600],
              selectedLabelStyle:
                  GoogleFonts.poppins(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  GoogleFonts.poppins(fontWeight: FontWeight.normal),
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
          color: isSelected
              ? Colors.lightGreenAccent.withOpacity(0.3)
              : Colors.transparent,
        ),
        child: FaIcon(
          icon,
          size: 24,
          color: isSelected ? const Color(0xFF27AE60) : Colors.grey[600],
        ),
      ),
      // Only show label when active (shifting will handle this behavior)
      label: label,
    );
  }
}
