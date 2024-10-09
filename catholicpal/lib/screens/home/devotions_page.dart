import 'package:catholicpal/providers/devotions_provider.dart';
import 'package:catholicpal/screens/home/devotion_details.dart';
import 'package:catholicpal/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:catholicpal/models/devotion_model.dart';

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

    // Load devotions using the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DevotionProvider>(context, listen: false).loadDevotions();
    });
  }

  @override
  void dispose() {
    // Dispose the ScrollController
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleFavorite(int index, Devotion devotion) {
    // Implement logic to toggle favorite
    // Here, you might call a method from the provider to update the favorite status
  }

  void _onDevotionTap(Devotion devotion) {
    // Navigate to the details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DevotionDetailsPage(devotion: devotion),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Devotions',
        scrollController: _scrollController,
        actions: const [],
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
                child: Consumer<DevotionProvider>(
                  builder: (context, devotionProvider, child) {
                    if (devotionProvider.devotions.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemBuilder: (context, index) {
                        final devotion = devotionProvider.devotions[index];

                        double height = (index % 2 == 0) ? 180 : 240;

                        return SizedBox(
                          height: height,
                          child: customImageContainer(
                            imageUrl: devotion.imageUrl,
                            title: devotion.name,
                            isFavorite: false, // Add logic for favorite status
                            onFavoriteTap: () =>
                                _toggleFavorite(index, devotion),
                            onTap: () => _onDevotionTap(devotion),
                            height: height,
                            showFavorite: false,
                          ),
                        );
                      },
                      itemCount: devotionProvider.devotions.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
