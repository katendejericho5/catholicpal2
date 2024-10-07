import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  late Box<List<DailyNews>> newsBox;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
  }

  Future<void> _openHiveBox() async {
    newsBox = await Hive.openBox<List<DailyNews>>('dailyNews');
  }

  Future<List<DailyNews>> fetchCachedDailyNews() async {
    // Try to get cached news from Hive
    if (newsBox.isNotEmpty) {
      return newsBox.get(0) ?? [];
    }
    return [];
  }

  Future<void> saveDailyNews(List<DailyNews> newsList) async {
    // Save the news list to Hive (overwrite if exists)
    await newsBox.put(0, newsList);
  }

  Future<List<DailyNews>> fetchDailyNews() async {
    // Check if cached data is available
    List<DailyNews> cachedNews = await fetchCachedDailyNews();
    if (cachedNews.isNotEmpty) {
      return cachedNews;
    }

    // If no cache, fetch data from the internet
    final response = await http.get(
      Uri.parse('https://feeds.feedburner.com/catholicnewsagency/dailynews'),
    );
    if (response.statusCode == 200) {
      var raw = xml.XmlDocument.parse(response.body);
      var elements = raw.findAllElements('item');
      List<DailyNews> newsList = elements.map((element) => DailyNews.fromXml(element)).toList();

      // Save fetched news to Hive cache
      await saveDailyNews(newsList);

      return newsList;
    } else {
      throw Exception('Failed to load Daily News');
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
        title: const Text('Daily News'),
        elevation: 0,
      ),
      body: FutureBuilder<List<DailyNews>>(
        future: fetchDailyNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<DailyNews> newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                DailyNews news = newsList[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (news.imageUrl.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                news.imageUrl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Published: ${news.formattedDate}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              news.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _launchUrl(news.link),
                              child: const Text('Read More'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
