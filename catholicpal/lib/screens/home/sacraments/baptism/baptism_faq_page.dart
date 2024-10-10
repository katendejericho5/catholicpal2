import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hugeicons/hugeicons.dart';

class BaptismFAQPage extends StatelessWidget {
  final List<Map<String, dynamic>> faqs = [
    {
      'question': 'Who can receive Baptism?',
      'answer':
          'Any person who has not already been baptized can receive the sacrament of Baptism.',
      'icon': HugeIcons.strokeRoundedKid,
    },
    {
      'question': 'Can someone be baptized twice?',
      'answer':
          'No, Baptism imparts an indelible spiritual mark and cannot be repeated.',
      'icon': HugeIcons
          .strokeRoundedUserQuestion02, // Different icon for this question
    },
    {
      'question': 'What is the role of godparents?',
      'answer':
          'Godparents are to be firm believers, able and ready to help the newly baptized on the road of Christian life.',
      'icon': HugeIcons.strokeRoundedCheckmarkCircle03, // Another icon
    },
    // Add more FAQs as needed
  ];

  BaptismFAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.greenAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Baptism FAQ',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // Increased font size for title
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://images.pexels.com/photos/28842438/pexels-photo-28842438/free-photo-of-statues-on-vatican-s-colonnade-in-black-and-white.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(
                              0.6), // Slightly reduced opacity for better visibility
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
                  return _buildFAQItem(faqs[index], context);
                },
                childCount: faqs.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        shadowColor: Colors.grey.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Inner padding for content
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  faq['icon'],
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
              ),
              // Icon(faq['icon'],
              //     color: Theme.of(context).primaryColor,
              //     size: 32), // Adjusted icon size
              const SizedBox(width: 16), // Spacing between icon and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      faq['question']!,
                      style: const TextStyle(
                        fontSize: 20, // Increased font size for question
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      faq['answer']!,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
