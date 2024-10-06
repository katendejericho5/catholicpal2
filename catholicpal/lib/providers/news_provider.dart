// import 'package:catholicpal/models/updates_model.dart';
// import 'package:flutter/material.dart';
// import 'package:xml/xml.dart' as xml;
// import 'package:http/http.dart' as http;

// class NewsProvider with ChangeNotifier {
//   List<NewsArticle> _articles = [];
//   bool _isLoading = false;
//   String _errorMessage = '';

//   List<NewsArticle> get articles => _articles;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;

//   Future<void> fetchNews() async {
//     _isLoading = true;
//     _errorMessage = '';
//     notifyListeners(); // Notify listeners that loading has started

//     try {
//       final response = await http
//           .get(Uri.parse('https://www.catholic.org/xml/rss_news.php'));

//       if (response.statusCode == 200) {
//         final document = xml.XmlDocument.parse(response.body);
//         final items = document.findAllElements('item');

//         _articles = items.map((item) {
//           final title = item.findElements('title').first.text;
//           final description = item.findElements('description').first.text;
//           final link = item.findElements('link').first.text;

//           return NewsArticle(
//               title: title, description: description, link: link);
//         }).toList();
//       } else {
//         _errorMessage = 'Failed to load RSS feed: ${response.statusCode}';
//       }
//     } catch (e) {
//       _errorMessage = 'An error occurred: $e';
//     } finally {
//       _isLoading = false;
//       notifyListeners(); // Notify listeners that loading has finished
//     }
//   }
// }
