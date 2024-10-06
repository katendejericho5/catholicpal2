import 'package:catholicpal/models/church_model.dart';
import 'package:flutter/material.dart';

class ChurchDetailsWidget extends StatelessWidget {
  final Church church;

  const ChurchDetailsWidget({super.key, required this.church});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(church.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(church.description),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Implement navigation to church here
              // You could use a package like url_launcher to open Google Maps
            },
            child: const Text('Navigate to Church'),
          ),
        ],
      ),
    );
  }
}
