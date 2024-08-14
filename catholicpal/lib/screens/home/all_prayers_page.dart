import 'package:flutter/material.dart';

class AllPrayersPage extends StatelessWidget {
  const AllPrayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Prayers'),
      ),
      body: const Center(
        child: Text('All prayers will be listed here.'),
      ),
    );
  }
}
