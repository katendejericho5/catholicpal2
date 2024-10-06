import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

class DailyNews {
  final String title;
  final String link;
  final String description;
  final String imageUrl;
  final DateTime publishDate;

  DailyNews({
    required this.title,
    required this.link,
    required this.description,
    required this.imageUrl,
    required this.publishDate,
  });

  factory DailyNews.fromXml(xml.XmlElement element) {
    String title = _extractCData(element.findElements('title').first);
    String link = element.findElements('link').first.text;
    String description = _extractCData(element.findElements('description').first);

    // Parse the HTML content
    dom.Document document = parse(description);

    // Extract image URL
    String imageUrl = document.querySelector('img')?.attributes['src'] ?? '';

    // Extract publish date
    String pubDateStr = element.findElements('pubDate').first.text;
    DateTime publishDate = DateFormat("EEE, dd MMM yyyy HH:mm:ss Z").parse(pubDateStr);

    // Clean up description
    description = _cleanDescription(document);

    return DailyNews(
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
    document.querySelector('div')?.remove();

    // Get the remaining text
    String cleanText = document.body?.text ?? '';

    // Remove extra whitespace
    return cleanText.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  String get formattedDate {
    return DateFormat('MMMM d, yyyy').format(publishDate);
  }
}