import 'package:catholicpal/services/prayer_service.dart';
import 'package:flutter/material.dart';
import 'package:catholicpal/screens/home/prayer_details.dart';
import 'package:catholicpal/screens/widgets/cards.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:catholicpal/models/prayer_model.dart';

class CategoryPrayersPage extends StatefulWidget {
  final String categoryId; // Accept category ID
  final String categoryName; // Accept category name

  const CategoryPrayersPage(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  State<CategoryPrayersPage> createState() => _CategoryPrayersPageState();
}

class _CategoryPrayersPageState extends State<CategoryPrayersPage> {
  late ScrollController _scrollController;
  late Future<List<Prayer>> _prayersFuture;
  late List<Color> _colors; // List to store predefined colors

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _prayersFuture = DataService().loadPrayers();
    _colors = _generateSpiritualColors(); // Initialize the color list
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function to generate a list of spiritual-friendly colors
  List<Color> _generateSpiritualColors() {
    return [
      const Color(0xffe0f7fa), // Light Cyan
      const Color(0xfff1f8e9), // Light Green
      const Color(0xfffce4ec), // Light Pink
      const Color(0xffede7f6), // Light Purple
      const Color(0xfffff3e0), // Light Orange
      // Add more colors as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.categoryName, // Use category name here
        scrollController: _scrollController,
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            Expanded(
              child: FutureBuilder<List<Prayer>>(
                future: _prayersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No prayers found.'));
                  }

                  final prayers = snapshot.data!;

                  // Filter prayers by categoryId
                  final filteredPrayers = prayers
                      .where((prayer) => prayer.categoryId == widget.categoryId)
                      .toList();

                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredPrayers.length,
                    itemBuilder: (context, index) {
                      final prayer = filteredPrayers[index];
                      // Use color from the predefined list
                      Color color = _colors[index % _colors.length];
                      return CardWidget(
                        title: prayer.name,
                        color: color,
                        iconPath: prayer.iconAssetUrl,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PrayerDetailsPage(prayer: prayer),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
