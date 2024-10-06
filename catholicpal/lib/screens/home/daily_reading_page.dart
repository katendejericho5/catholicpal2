import 'package:catholicpal/models/daily_reading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

class DailyReadingsPage extends StatefulWidget {
  const DailyReadingsPage({Key? key}) : super(key: key);

  @override
  _DailyReadingsPageState createState() => _DailyReadingsPageState();
}

class _DailyReadingsPageState extends State<DailyReadingsPage> {
  Future<DailyReading> fetchDailyReading() async {
    final response =
        await http.get(Uri.parse('https://bible.usccb.org/readings.rss'));
    if (response.statusCode == 200) {
      var raw = xml.XmlDocument.parse(response.body);
      var element = raw.findAllElements('item').first;
      return DailyReading.fromXml(element);
    } else {
      throw Exception('Failed to load Daily Reading');
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
        title: const Text('Daily Readings'),
        elevation: 0,
      ),
      body: FutureBuilder<DailyReading>(
        future: fetchDailyReading(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            DailyReading reading = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reading.title,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
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
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
