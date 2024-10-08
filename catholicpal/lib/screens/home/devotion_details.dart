import 'package:flutter/material.dart';
import 'package:catholicpal/models/devotion_model.dart'; // Import the Devotion model

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
              // Devotion Image
              Image.network(
                devotion.imageUrl,
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
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
                    leading: Image.asset(prayer.iconAssetUrl, width: 40, height: 40),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Associated Saints or Persons
              Text(
                'Associated Saints:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: devotion.associatedSaintsOrPersons.map((saint) {
                  return ListTile(
                    title: Text(saint.name),
                    subtitle: Text(saint.description),
                    leading: Image.network(saint.imageUrl, width: 40, height: 40),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
