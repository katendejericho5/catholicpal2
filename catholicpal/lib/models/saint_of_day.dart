import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

part 'saint_of_day.g.dart';

@HiveType(typeId: 0)
class SaintOfTheDay extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String link;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final DateTime feastDate;
  @HiveField(5)
  final DateTime lastUpdated;

  SaintOfTheDay({
    required this.title,
    required this.link,
    required this.description,
    required this.imageUrl,
    required this.feastDate,
    required this.lastUpdated,
  });

  factory SaintOfTheDay.fromXml(xml.XmlElement element) {
    String title = _extractCData(element.findElements('title').first);
    String link = element.findElements('link').first.text;
    String description =
        _extractCData(element.findElements('description').first);

    // Parse the HTML content
    dom.Document document = parse(description);

    // Extract image URL
    String imageUrl = document.querySelector('img')?.attributes['src'] ?? '';

    // Extract feast date
    String feastDateStr = document.querySelector('p')?.text ?? '';
    DateTime feastDate = _parseFeastDate(feastDateStr);

    // Clean up description
    description = _cleanDescription(document);

    return SaintOfTheDay(
      title: title,
      link: link,
      description: description,
      imageUrl: imageUrl,
      feastDate: feastDate,
      lastUpdated: DateTime.now(),
    );
  }

  static String _extractCData(xml.XmlElement element) {
    return element.children
        .whereType<xml.XmlCDATA>()
        .map((cdata) => cdata.text)
        .join()
        .trim();
  }

  static DateTime _parseFeastDate(String feastDateStr) {
    RegExp regExp = RegExp(r'Feast date: (\w{3} \d{2})');
    Match? match = regExp.firstMatch(feastDateStr);
    if (match != null) {
      String dateStr = match.group(1)!;
      return DateFormat('MMM dd yyyy').parse('$dateStr ${DateTime.now().year}');
    }
    return DateTime.now();
  }

  static String _cleanDescription(dom.Document document) {
    // Remove the image and feast date paragraphs
    document.querySelector('div')?.remove();
    document.querySelector('p')?.remove();

    // Get the remaining text
    String cleanText = document.body?.text ?? '';

    // Remove extra whitespace
    return cleanText.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  String get saintName {
    return title.replaceAll(RegExp(r',.*$'), '').trim();
  }

  String get formattedDate {
    return DateFormat('MMMM d').format(feastDate);
  }
}
