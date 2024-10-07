import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:html/parser.dart' show parse;
import 'package:hive/hive.dart';  // Import Hive package
import 'package:hive_flutter/hive_flutter.dart';  // If using Hive with Flutter

import 'package:html/dom.dart' as dom;
part 'catholic_answers_model.g.dart';

@HiveType(typeId: 3)
class CatholicAnswersNews {
  static const String baseUrl = 'https://shop.catholic.com';
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String link;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final DateTime publishDate;

  CatholicAnswersNews({
    required this.title,
    required this.link,
    required this.description,
    required this.imageUrl,
    required this.publishDate,
  });

  factory CatholicAnswersNews.fromXml(xml.XmlElement element) {
    String title = _extractCData(element.findElements('title').first);
    String link = element.findElements('link').first.text;
    String description =
        _extractCData(element.findElements('description').first);

    // Parse the HTML content
    dom.Document document = parse(description);

    // Extract image URL and prepend base URL if necessary
    String imageUrl = document.querySelector('img')?.attributes['src'] ?? '';
    imageUrl = _completeImageUrl(imageUrl);

    // Extract publish date
    String pubDateStr = element.findElements('pubDate').first.text;
    DateTime publishDate =
        DateFormat("EEE, dd MMM yyyy HH:mm:ss Z").parse(pubDateStr);

    // Clean up description
    description = _cleanDescription(document);

    return CatholicAnswersNews(
      title: title,
      link: link,
      description: description,
      imageUrl: imageUrl,
      publishDate: publishDate,
    );
  }

  static String _extractCData(xml.XmlElement element) {
    return element.children
        .whereType<xml.XmlCDATA>()
        .map((cdata) => cdata.text)
        .join()
        .trim();
  }

  static String _cleanDescription(dom.Document document) {
    // Remove the image
    document.querySelector('img')?.remove();

    // Get the remaining text
    String cleanText = document.body?.text ?? '';

    // Remove extra whitespace
    return cleanText.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  static String _completeImageUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    } else {
      return baseUrl + url;
    }
  }

  String get formattedDate {
    return DateFormat('MMMM d, yyyy').format(publishDate);
  }
}
