import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;

class SaintOfTheDay {
  final String title;
  final String link;
  final String description;
  final String author;
  final DateTime pubDate;

  SaintOfTheDay({
    required this.title,
    required this.link,
    required this.description,
    required this.author,
    required this.pubDate,
  });

  factory SaintOfTheDay.fromXml(xml.XmlElement element) {
    String title = element.findElements('title').first.text;
    String link = element.findElements('link').first.text;
    String description = element.findElements('description').first.text;
    String author = element.findElements('author').first.text;
    String pubDateString = element.findElements('pubDate').first.text;

    DateTime pubDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(pubDateString);

    return SaintOfTheDay(
      title: title,
      link: link,
      description: description,
      author: author,
      pubDate: pubDate,
    );
  }

  String get saintName {
    RegExp regExp = RegExp(r'St\.\s+([\w\s]+):');
    Match? match = regExp.firstMatch(title);
    return match != null ? match.group(1)! : 'Unknown Saint';
  }

  String get formattedDate {
    return DateFormat('MMMM d, y').format(pubDate);
  }
}
