import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class BaptismRitePage extends StatelessWidget {
  final List<Map<String, dynamic>> steps = [
    {
      'title': 'Reception of the Child',
      'description':
          "The celebrant greets the family and asks for the child's name.",
      'icon': HugeIcons.strokeRoundedKid,
    },
    {
      'title': 'Liturgy of the Word',
      'description':
          'Scripture readings and homily on the significance of Baptism.',
      'icon': HugeIcons.strokeRoundedBook04
    },
    {
      'title': 'Blessing of Water',
      'description':
          'The celebrant blesses the water to be used in the Baptism.',
      'icon': HugeIcons.strokeRoundedWaterEnergy
    },
    {
      'title': 'Renunciation of Sin and Profession of Faith',
      'description':
          'Parents and godparents renounce sin and profess their faith.',
      'icon': HugeIcons.strokeRoundedCheckmarkCircle03,
    },
    {
      'title': 'Baptism',
      'description':
          "The celebrant pours water over the child's head three times.",
      'icon': HugeIcons.strokeRoundedDroplet,
    },
    {
      'title': 'Anointing with Chrism',
      'description':
          'The child is anointed with holy oil as a sign of sealing with the Holy Spirit.',
      'icon': HugeIcons.strokeRoundedSoilMoistureField,
    },
    {
      'title': 'Clothing with White Garment',
      'description':
          'The child is clothed in a white garment, symbolizing purity.',
      'icon': HugeIcons.strokeRoundedClothes,
    },
    {
      'title': 'Lighting of Baptismal Candle',
      'description':
          'A candle is lit from the Paschal candle, symbolizing the light of Christ.',
      'icon': HugeIcons.strokeRoundedCandelier01,
    },
  ];

  BaptismRitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.greenAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title:  Text(
                'Baptism Rite',
                textAlign: TextAlign.center,
                style:  GoogleFonts.poppins(
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
                        'https://images.pexels.com/photos/208356/pexels-photo-208356.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildStepItem(steps[index], context);
                },
                childCount: steps.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(Map<String, dynamic> step, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.grey.withOpacity(0.2),
      margin: const EdgeInsets.only(bottom: 16),
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
                  child: Icon(step['icon'],
                      color: Theme.of(context).primaryColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    step['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              step['description'],
              style:  GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
