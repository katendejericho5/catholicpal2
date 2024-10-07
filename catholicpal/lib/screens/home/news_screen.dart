import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/models/news_model.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  Future<List<DailyNews>>? _newsFuture; // Adjust the model as per your code
  late ScrollController _scrollController;

  // Hive Box name
  final String newsBoxName = 'news_cache';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Initialize Hive box for caching news
    Hive.openBox(newsBoxName).then((_) {
      setState(() {
        _newsFuture = fetchNews();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // close box
    Hive.box(newsBoxName).close();
    super.dispose();
  }

  Future<List<DailyNews>> fetchNews() async {
    try {
      final response = await http.get(
        Uri.parse('https://feeds.feedburner.com/catholicnewsagency/dailynews'),
      );
      if (response.statusCode == 200) {
        var raw = xml.XmlDocument.parse(response.body);
        var elements = raw.findAllElements('item');
        List<DailyNews> newsList = elements
            .map(
                (element) => DailyNews.fromXml(element)) // Adjust to your model
            .toList();

        // Cache the news data in Hive
        var newsBox = Hive.box(newsBoxName);
        newsBox.put('newsList', newsList);

        return newsList;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      // If fetching from network fails, load cached news
      var newsBox = Hive.box(newsBoxName);
      if (newsBox.containsKey('newsList')) {
        return List<DailyNews>.from(newsBox.get('newsList'));
      } else {
        throw Exception('No internet and no cached data available');
      }
    }
  }

  String getRandomImageUrl() {
    int randomNumber = Random().nextInt(1000);
    return 'https://picsum.photos/seed/$randomNumber/400/300';
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString(), forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'DailyNews',
        scrollController: _scrollController,
        actions: const [],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _newsFuture = fetchNews();
          });
        },
        child: FutureBuilder<List<DailyNews>>(
          future: _newsFuture,
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
                            margin: const EdgeInsets.all(8.0),
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: news.imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: Colors.white,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    CachedNetworkImage(
                                  imageUrl: getRandomImageUrl(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.white,
                                      height: 200,
                                      width: double.infinity,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
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
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Published: ${news.formattedDate}', // Ensure this exists in your model
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                news.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => _launchUrl(news
                                    .link), // Ensure this exists in your model
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
      ),
    );
  }
}
