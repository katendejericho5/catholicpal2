import 'package:catholicpal/models/updates_model.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  Future<List<NewsArticle>> getArticles(BuildContext context) async {
    String xmlString =
        await DefaultAssetBundle.of(context).loadString('assets/news.xml');
    var raw = xml.XmlDocument.parse(xmlString);
    var elements =
        raw.findAllElements('item'); // Use 'item' for individual news articles
    return elements.map((element) {
      return NewsArticle(
        title: element.findElements('title').first.text,
        description: element.findElements('description').first.text,
        link: element.findElements('link').first.text,
        author: element.findElements('author').first.text,
        pubDate: element.findElements('pubDate').first.text,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: getArticles(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<NewsArticle> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article.description,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'By: ${article.author}',
                          style: const TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Published on: ${article.pubDate}',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle logic to open the article link
                              // E.g., launch URL in browser
                            },
                            child: const Text(
                              'Read More',
                              style: TextStyle(color: Colors.teal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No news available'));
          }
        },
      ),
    );
  }
}
