import 'package:catholicpal/models/daily_reading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DailyReadingsPage extends StatefulWidget {
  const DailyReadingsPage({super.key});

  @override
  DailyReadingsPageState createState() => DailyReadingsPageState();
}

class DailyReadingsPageState extends State<DailyReadingsPage> {
  Box<DailyReading>? readingBox;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    initHive();
  }

  Future<void> initHive() async {
    try {
      readingBox = await Hive.openBox<DailyReading>('dailyReading');
      await loadDailyReading();
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to initialize: $e';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    readingBox?.close();
    super.dispose();
  }

  Future<void> loadDailyReading() async {
    if (readingBox == null) return;

    setState(() => isLoading = true);
    try {
      // Load cached data first
      DailyReading? cachedReading = readingBox!.get('current');
      if (cachedReading != null) {
        setState(() => isLoading = false);
      }

      // Check for internet connection and update in the background
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        await updateDailyReading();
      }
    } catch (e) {
      setState(() => errorMessage = e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateDailyReading() async {
    if (readingBox == null) return;

    try {
      final response =
          await http.get(Uri.parse('https://bible.usccb.org/readings.rss'));
      if (response.statusCode == 200) {
        var raw = xml.XmlDocument.parse(response.body);
        var element = raw.findAllElements('item').first;
        final reading = DailyReading.fromXml(element);

        // Save fetched reading to Hive
        await readingBox!.put('current', reading);
        setState(() {}); // Trigger a rebuild to show updated data
      } else {
        throw Exception('Failed to load Daily Reading');
      }
    } catch (e) {
      // Handle error silently or show a subtle notification
      setState(() => errorMessage = 'Error updating Daily Reading: $e');
    }
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Readings'),
        elevation: 0,
      ),
      body: readingBox == null
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder(
              valueListenable: readingBox!.listenable(),
              builder: (context, Box<DailyReading> box, _) {
                final reading = box.get('current');
                if (isLoading && reading == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (reading == null) {
                  if (kDebugMode) {
                    print(errorMessage);
                  }
                  return const Center(
                      child: Text('Oops! Something went wrong'));
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reading.title,
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
                          'Published: ${reading.formattedDate}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Html(
                          data: reading.description,
                          style: {
                            "body": Style(fontSize: FontSize(16)),
                            "h4": Style(color: Theme.of(context).primaryColor),
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _launchUrl(reading.link),
                          child: const Text('Read More'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
