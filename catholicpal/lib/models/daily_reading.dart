import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'daily_reading.g.dart';

@HiveType(typeId: 4)
class DailyReading {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String link;

  @HiveField(2)
  final String description;

  @HiveField(3)
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