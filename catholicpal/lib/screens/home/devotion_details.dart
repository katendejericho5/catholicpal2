import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:catholicpal/models/devotion_model.dart';
import 'package:shimmer/shimmer.dart'; // Import the Devotion model

class DevotionDetailsPage extends StatelessWidget {
  final Devotion devotion;

  const DevotionDetailsPage({super.key, required this.devotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(devotion.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 10,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: devotion.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Devotion Name
              Text(
                devotion.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              // Devotion Description
              Text(
                devotion.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              // History
              Text(
                'History:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                devotion.history,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              // Associated Prayers
              Text(
                'Associated Prayers:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: devotion.prayers.map((prayer) {
                  return ListTile(
                    title: Text(prayer.name),
                    subtitle: Text(prayer.details),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Associated Saints or Persons
            ],
          ),
        ),
      ),
    );
  }
}
