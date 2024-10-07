import 'package:catholicpal/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';

class DevotionsPage extends StatefulWidget {
  const DevotionsPage({super.key});

  @override
  State<DevotionsPage> createState() => _DevotionsPageState();
}

class _DevotionsPageState extends State<DevotionsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Initialize the ScrollController
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // Dispose the ScrollController
    _scrollController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> devotions = [
    {
      'title': 'Rosary',
      'imageUrl':
          'https://images.pexels.com/photos/5647609/pexels-photo-5647609.jpeg?auto=compress&cs=tinysrgb&w=600',
      'isFavorite': false,
    },
    {
      'title': 'Divine Mercy',
      'imageUrl':
          'https://images.pexels.com/photos/5647609/pexels-photo-5647609.jpeg?auto=compress&cs=tinysrgb&w=600',
      'isFavorite': false,
    },
    {
      'title': 'Stations of the Cross',
      'imageUrl':
          'https://images.pexels.com/photos/5647609/pexels-photo-5647609.jpeg?auto=compress&cs=tinysrgb&w=600',
      'isFavorite': false,
    },
    {
      'title': 'Novenas',
      'imageUrl':
          'https://images.pexels.com/photos/5647609/pexels-photo-5647609.jpeg?auto=compress&cs=tinysrgb&w=600',
      'isFavorite': false,
    },
    {
      'title': 'Litanies',
      'imageUrl':
          'https://images.pexels.com/photos/5647609/pexels-photo-5647609.jpeg?auto=compress&cs=tinysrgb&w=600',
      'isFavorite': false,
    },
    {
      'title': 'Adoration',
      'imageUrl':
          'https://images.pexels.com/photos/5647609/pexels-photo-5647609.jpeg?auto=compress&cs=tinysrgb&w=600',
      'isFavorite': false,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      devotions[index]['isFavorite'] = !devotions[index]['isFavorite'];
    });
  }

  void _onDevotionTap(int index) {
    // Handle devotion tap
    print('Tapped on: ${devotions[index]['title']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Devotions',
        scrollController: _scrollController, actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
              child: TextField(
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
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemBuilder: (context, index) {
                    // Randomly determine the height for each card
                    double height =
                        (index % 2 == 0) ? 180 : 240; // Different heights

                    return SizedBox(
                      height: height,
                      child: customImageContainer(
                        imageUrl: devotions[index]['imageUrl'],
                        title: devotions[index]['title'],
                        isFavorite: devotions[index]['isFavorite'],
                        onFavoriteTap: () => _toggleFavorite(index),
                        onTap: () => _onDevotionTap(index),
                        height: height, // Pass the custom height
                        showFavorite: true,
                      ),
                    );
                  },
                  itemCount: devotions.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
