import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/models/prayer_of_the_day.dart';
import 'package:flutter/foundation.dart';
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
  Box<PrayerOfTheDay>? prayerBox;
  PrayerOfTheDay? prayerOfTheDay;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _openHiveBox().then((_) {
      _fetchPrayerOfTheDay();
    });
  }

  @override
  void dispose() {
    prayerBox?.close();
    super.dispose();
  }

  Future<void> _openHiveBox() async {
    // Initialize Hive and open the box for PrayerOfTheDay
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PrayerOfTheDayAdapter());
    }
    prayerBox = await Hive.openBox<PrayerOfTheDay>('prayerOfTheDay');
  }

  Future<void> _fetchPrayerOfTheDay() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Try to get cached prayer
      PrayerOfTheDay? cachedPrayer = await _getCachedPrayerOfTheDay();

      if (cachedPrayer != null) {
        setState(() {
          prayerOfTheDay = cachedPrayer;
          isLoading = false;
        });
      } else {
        // If no cached prayer, fetch from network
        PrayerOfTheDay fetchedPrayer = await _fetchFromNetwork();
        await _savePrayerOfTheDay(fetchedPrayer);

        setState(() {
          prayerOfTheDay = fetchedPrayer;
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching prayer: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<PrayerOfTheDay?> _getCachedPrayerOfTheDay() async {
    // Return the cached prayer if available
    if (prayerBox != null && prayerBox!.isNotEmpty) {
      return prayerBox!.getAt(0);
    }
    return null;
  }

  Future<void> _savePrayerOfTheDay(PrayerOfTheDay prayer) async {
    // Save or update prayer data in the cache
    await prayerBox?.put(0, prayer);
  }

  Future<PrayerOfTheDay> _fetchFromNetwork() async {
    // Fetch prayer data from the network
    final response =
        await http.get(Uri.parse('https://www.catholic.org/xml/rss_pofd.php'));

    if (response.statusCode == 200) {
      var rawXml = xml.XmlDocument.parse(response.body);
      var item = rawXml.findAllElements('item').first;
      return PrayerOfTheDay.fromXml(item);
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

  String getImageUrl() {
    // Generate a random image URL from picsum.photos
    return 'https://images.pexels.com/photos/1615776/pexels-photo-1615776.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer of the Day'),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : prayerOfTheDay != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              getImageUrl(),
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
                              prayerOfTheDay!.title,
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
                              'Published: ${prayerOfTheDay!.formattedDate}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              prayerOfTheDay!.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _launchUrl(prayerOfTheDay!.link),
                              child: const Text('Read More'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: Text('No data available')),
    );
  }
}
