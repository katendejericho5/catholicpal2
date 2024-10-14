import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/models/catholic_answers_model.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:catholicpal/screens/widgets/error_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';

class CatholicAnswersNewsScreen extends StatefulWidget {
  const CatholicAnswersNewsScreen({super.key});

  @override
  CatholicAnswersNewsScreenState createState() =>
      CatholicAnswersNewsScreenState();
}

class CatholicAnswersNewsScreenState extends State<CatholicAnswersNewsScreen> {
  Future<List<CatholicAnswersNews>>? _newsFuture;
  late ScrollController _scrollController;

  // Hive Box name
  final String newsBoxName = 'catholic_answers_news';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Initialize Hive box for caching news
    Hive.openBox(newsBoxName).then((_) {
      setState(() {
        _newsFuture = fetchCatholicAnswersNews();
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

  Future<List<CatholicAnswersNews>> fetchCatholicAnswersNews() async {
    // Try to get data from the network
    try {
      final response = await http.get(Uri.parse(
          'https://shop.catholic.com/rss.php?action=newblogs&type=rss'));
      if (response.statusCode == 200) {
        var raw = xml.XmlDocument.parse(response.body);
        var elements = raw.findAllElements('item');
        List<CatholicAnswersNews> newsList = elements
            .map((element) => CatholicAnswersNews.fromXml(element))
            .toList();

        // Cache the news data in Hive
        var newsBox = Hive.box(newsBoxName);
        newsBox.put('newsList', newsList);

        return newsList;
      } else {
        throw Exception('Failed to load Catholic Answers News');
      }
    } catch (e) {
      // If fetching from network fails, load cached news
      var newsBox = Hive.box(newsBoxName);
      if (newsBox.containsKey('newsList')) {
        return List<CatholicAnswersNews>.from(newsBox.get('newsList'));
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
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Catholic Answers',
        scrollController: _scrollController,
        actions: const [],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _newsFuture = fetchCatholicAnswersNews();
          });
        },
        child: FutureBuilder<List<CatholicAnswersNews>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              if (kDebugMode) {
                print(snapshot.error);
              }
              return const NoconnectionScreen();
            } else if (snapshot.hasData) {
              List<CatholicAnswersNews> newsList = snapshot.data!;
              return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  CatholicAnswersNews news = newsList[index];
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
                                'Published: ${news.formattedDate}',
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
      ),
    );
  }
}
