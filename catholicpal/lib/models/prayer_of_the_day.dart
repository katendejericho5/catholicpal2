import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;

class PrayerOfTheDay {
  final String title;
  final String link;
  final String description;
  final DateTime publishDate;

  PrayerOfTheDay({
    required this.title,
    required this.link,
    required this.description,
    required this.publishDate,
  });

  factory PrayerOfTheDay.fromXml(xml.XmlElement element) {
    String title = element.findElements('title').first.text;
    String link = element.findElements('link').first.text;
    String description = element.findElements('description').first.text;

    // Extract publish date
    String pubDateStr = element.findElements('pubDate').first.text;
    DateTime publishDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(pubDateStr);

    return PrayerOfTheDay(
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