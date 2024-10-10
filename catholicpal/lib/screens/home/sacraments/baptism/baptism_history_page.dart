import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hugeicons/hugeicons.dart';

class BaptismHistoryPage extends StatelessWidget {
  const BaptismHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.greenAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'History & Salvation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://images.pexels.com/photos/10619928/pexels-photo-10619928.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
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
                      return _buildCatechismCard(
                        'Origins of Baptism',
                        'Baptism has its roots in Jewish purification rituals. John the Baptist preached a baptism of repentance, which Jesus himself underwent. After his resurrection, Jesus commanded his disciples to baptize all nations (Matthew 28:19-20).',
                        HugeIcons.strokeRoundedWorkHistory,
                        context,
                      );
                    case 1:
                      return _buildCatechismCard(
                        'Significance in Salvation',
                        'Baptism is the foundation of the Christian life, the gateway to life in the Spirit, and the door which gives access to the other sacraments. Through Baptism we are freed from sin and reborn as children of God.',
                        HugeIcons.strokeRoundedIdea01,
                        context,
                      );
                    case 2:
                      return _buildCatechismCard(
                        'Key Biblical References',
                        '• Matthew 28:19-20\n• Acts 2:38\n• Romans 6:3-4',
                        HugeIcons.strokeRoundedBook04,
                        context,
                      );
                    case 3:
                      return _buildCatechismCard(
                        'Timeline of Baptism',
                        '• 1st Century: Early Christian practices\n• 2nd-3rd Centuries: Catechumenate development\n• 4th-5th Centuries: Infant baptism spreads\n• Middle Ages: Theological developments\n• 16th Century: Reformation debates\n• 20th Century: Renewal of practices',
                        HugeIcons.strokeRoundedClock03,
                        context,
                      );
                    default:
                      return Container();
                  }
                },
                childCount: 4,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement link to additional resources
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
                child: const Text(
                  'Learn More',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatechismCard(
      String title, String content, IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
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
                      style: const TextStyle(
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
                style: const TextStyle(
                    fontSize: 16, height: 1.5, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
