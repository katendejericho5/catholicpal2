import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: -10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image section
            Stack(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.pexels.com/photos/2123307/pexels-photo-2123307.jpeg?auto=compress&cs=tinysrgb&w=600'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Saint Peter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          CupertinoIcons.forward,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ), // Spacing between the image and tab view

            // TabBar
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  300, // Adjust height for tab view
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TabBar(
                        tabs: const [
                          Tab(text: 'Overview'),
                          Tab(text: 'Prayer'),
                        ],
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey[300],
                        indicatorColor: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          // Overview Tab
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Overview',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Saint Peter was one of the twelve apostles of Jesus Christ. According to the New Testament, he was a fisherman by trade. Saint Peter is considered a central figure in Christianity, and his teachings are fundamental to the faith.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  // Add more overview content here
                                ],
                              ),
                            ),
                          ),
                          // Prayer Tab
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Prayer',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Lord Jesus Christ, you have called us to be your disciples and to follow you. We ask that you strengthen our faith and help us to remain true to your teachings. May Saint Peter’s example inspire us to live a life of devotion and love. Amen.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  // Add more prayer content here
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
