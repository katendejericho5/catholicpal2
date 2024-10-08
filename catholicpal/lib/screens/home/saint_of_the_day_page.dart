import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/models/saint_of_day.dart';
import 'package:catholicpal/screens/widgets/custom_appbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:url_launcher/url_launcher.dart';

class SaintOfTheDayPage extends StatefulWidget {
  const SaintOfTheDayPage({super.key});

  @override
  SaintOfTheDayPageState createState() => SaintOfTheDayPageState();
}

class SaintOfTheDayPageState extends State<SaintOfTheDayPage>
    with WidgetsBindingObserver {
  Box<SaintOfTheDay>? saintBox;
  bool isLoading = true;
  late ScrollController _scrollController;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    initHive();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    saintBox?.close();
    super.dispose();
  }

  Future<void> initHive() async {
    try {
      saintBox = await Hive.openBox<SaintOfTheDay>('saintOfTheDay');
      await loadSaintOfTheDay();
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to initialize: $e';
        isLoading = false;
      });
    }
  }

  Future<void> loadSaintOfTheDay() async {
    if (saintBox == null) return;

    setState(() => isLoading = true);
    try {
      // Always load from cache first
      SaintOfTheDay? cachedSaint = saintBox!.get('current');
      if (cachedSaint != null) {
        setState(() => isLoading = false);
      }

      // Check for internet connection and update in the background
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        await updateSaintOfTheDay();
      }
    } catch (e) {
      setState(() => errorMessage = e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateSaintOfTheDay() async {
    if (saintBox == null) return;

    try {
      final response = await http.get(Uri.parse(
          'https://feeds.feedburner.com/catholicnewsagency/saintoftheday'));
      if (response.statusCode == 200) {
        var raw = xml.XmlDocument.parse(response.body);
        var element = raw.findAllElements('item').first;
        final saint = SaintOfTheDay.fromXml(element);
        await saintBox!.put('current', saint);
        setState(() {}); // Trigger a rebuild to show updated data
      } else {
        throw Exception('Failed to load Saint of the Day');
      }
    } catch (e) {
      // Handle error silently or show a subtle notification
      if (kDebugMode) {
        print('Error updating Saint of the Day: $e');
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Saint of the Day',
        scrollController: _scrollController,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadSaintOfTheDay,
          ),
        ],
      ),
      body: saintBox == null
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder(
              valueListenable: saintBox!.listenable(),
              builder: (context, Box<SaintOfTheDay> box, _) {
                final saint = box.get('current');
                if (isLoading && saint == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (saint == null) {
                  if (kDebugMode) {
                    print(errorMessage.isEmpty
                        ? 'No data available'
                        : errorMessage);
                  }
                  return const Center(
                      child: Text('Oops! Something went wrong'));
                }
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (saint.imageUrl.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.all(15),
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                saint.imageUrl,
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
                              saint.saintName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Feast Day: ${saint.formattedDate}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              saint.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () => _launchUrl(saint.link),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                              ),
                              child: const Text('Read More'),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Last updated: ${saint.lastUpdated.toLocal()}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
