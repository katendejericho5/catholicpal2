import 'package:catholicpal/models/saint_of_day.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';

class SaintOfTheDayPage extends StatefulWidget {
  const SaintOfTheDayPage({Key? key}) : super(key: key);

  @override
  _SaintOfTheDayPageState createState() => _SaintOfTheDayPageState();
}

class _SaintOfTheDayPageState extends State<SaintOfTheDayPage> {
  Future<SaintOfTheDay> fetchSaintOfTheDay() async {
    final response =
        await http.get(Uri.parse('https://www.catholic.org/xml/rss_sofd.php'));
    if (response.statusCode == 200) {
      var raw = xml.XmlDocument.parse(response.body);
      var element = raw.findAllElements('item').first;
      return SaintOfTheDay.fromXml(element);
    } else {
      throw Exception('Failed to load Saint of the Day');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saint of the Day'),
        elevation: 0,
      ),
      body: FutureBuilder<SaintOfTheDay>(
        future: fetchSaintOfTheDay(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            SaintOfTheDay saint = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      saint.saintName,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      saint.formattedDate,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      saint.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => _launchUrl(saint.link),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text(
                        'Read More',
                        style: TextStyle(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Source: ${saint.author}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
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
