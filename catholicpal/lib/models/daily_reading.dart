import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;

class DailyReading {
  final String title;
  final String link;
  final String description;
  final DateTime publishDate;

  DailyReading({
    required this.title,
    required this.link,
    required this.description,
    required this.publishDate,
  });

  factory DailyReading.fromXml(xml.XmlElement element) {
    String title = element.findElements('title').first.text;
    String link = element.findElements('link').first.text;
    String description = element.findElements('description').first.text;

    // Extract publish date
    String pubDateStr = element.findElements('pubDate').first.text;
    DateTime publishDate = DateFormat("EEE, dd MMM yyyy HH:mm:ss Z").parse(pubDateStr);

    return DailyReading(
      title: title,
      link: link,
      description: description,
      publishDate: publishDate,
    );
  }

  String get formattedDate {
    return DateFormat('MMMM d, yyyy').format(publishDate);
  }
}