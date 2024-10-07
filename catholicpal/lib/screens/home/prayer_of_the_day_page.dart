import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/models/prayer_of_the_day.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class PrayerOfTheDayPage extends StatefulWidget {
  const PrayerOfTheDayPage({super.key});

  @override
  PrayerOfTheDayPageState createState() => PrayerOfTheDayPageState();
}

class PrayerOfTheDayPageState extends State<PrayerOfTheDayPage> {
  late Box<PrayerOfTheDay> prayerBox;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
  }

  Future<void> _openHiveBox() async {
    prayerBox = await Hive.openBox<PrayerOfTheDay>('prayerOfTheDay');
  }

  Future<PrayerOfTheDay?> fetchCachedPrayerOfTheDay() async {
    // Try to get cached prayer from Hive
    if (prayerBox.isNotEmpty) {
      return prayerBox.get(0);
    }
    return null;
  }

  Future<void> savePrayerOfTheDay(PrayerOfTheDay prayer) async {
    // Save the prayer into Hive (overwrite if exists)
    await prayerBox.put(0, prayer);
  }

  Future<PrayerOfTheDay> fetchPrayerOfTheDay() async {
    // Check if cached data is available
    PrayerOfTheDay? cachedPrayer = await fetchCachedPrayerOfTheDay();
    if (cachedPrayer != null) {
      return cachedPrayer;
    }

    // If no cache, fetch data from the internet
    final response =
        await http.get(Uri.parse('https://www.catholic.org/xml/rss_pofd.php'));
    if (response.statusCode == 200) {
      var raw = xml.XmlDocument.parse(response.body);
      var element = raw.findAllElements('item').first;
      PrayerOfTheDay prayer = PrayerOfTheDay.fromXml(element);

      // Save fetched prayer to Hive cache
      await savePrayerOfTheDay(prayer);

      return prayer;
    } else {
      throw Exception('Failed to load Prayer of the Day');
    }
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getRandomImageUrl() {
    int randomNumber = Random().nextInt(1000);
    return 'https://picsum.photos/seed/$randomNumber/400/300';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer of the Day'),
        elevation: 0,
      ),
      body: FutureBuilder<PrayerOfTheDay>(
        future: fetchPrayerOfTheDay(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            PrayerOfTheDay prayer = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    width: double.infinity,
                    height: 200, // Use provided height or default to 150
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          getRandomImageUrl(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prayer.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Published: ${prayer.formattedDate}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          prayer.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _launchUrl(prayer.link),
                          child: const Text('Read More'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
