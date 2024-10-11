import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class SpiritualGrowthPage extends StatelessWidget {
  const SpiritualGrowthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Spiritual Growth',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://images.pexels.com/photos/5418213/pexels-photo-5418213.jpeg?auto=compress&cs=tinysrgb&w=600',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return _buildGrowthSection(
                        'Prayer',
                        'Develop a consistent prayer life. Set aside time each day for personal prayer and meditation.',
                        HugeIcons.strokeRoundedHandPrayer,
                        context,
                      );
                    case 1:
                      return _buildGrowthSection(
                        'Scripture Study',
                        'Read and reflect on the Bible regularly. Consider joining a Bible study group or using guided devotionals.',
                        HugeIcons.strokeRoundedBook02,
                        context,
                      );
                    case 2:
                      return _buildGrowthSection(
                        'Sacraments',
                        'Participate in the sacraments regularly, especially the Eucharist and Reconciliation.',
                        HugeIcons.strokeRoundedCroissant,
                        context,
                      );
                    case 3:
                      return _buildGrowthSection(
                        'Service',
                        'Engage in acts of charity and service to others, reflecting Christ\'s love in your community.',
                        HugeIcons.strokeRoundedHeartCheck,
                        context,
                      );
                    case 4:
                      return _buildGrowthSection(
                        'Spiritual Direction',
                        'Consider seeking guidance from a spiritual director to help you discern God\'s will and grow in your faith.',
                        HugeIcons.strokeRoundedMessage02,
                        context,
                      );
                    case 5:
                      return _buildGrowthSection(
                        'Community',
                        'Participate actively in your parish community and consider joining faith-based groups or ministries.',
                        HugeIcons.strokeRoundedGroupItems,
                        context,
                      );
                    default:
                      return Container();
                  }
                },
                childCount: 6,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement link to spiritual growth resources
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Spiritual Growth Resources',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthSection(
      String title, String content, IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.grey.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      icon,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                content,
                style: GoogleFonts.poppins(
                    fontSize: 16, height: 1.5, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
