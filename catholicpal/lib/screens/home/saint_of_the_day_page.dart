import 'package:catholicpal/providers/saint_of_the_day_provider.dart';
import 'package:catholicpal/screens/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class SaintOfTheDayPage extends StatefulWidget {
  const SaintOfTheDayPage({super.key});

  @override
  State<SaintOfTheDayPage> createState() => _SaintOfTheDayPageState();
}

class _SaintOfTheDayPageState extends State<SaintOfTheDayPage> {
  @override
  void initState() {
    super.initState();
    // Delay the provider access until after the first frame to avoid issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<SaintOfTheDayProvider>(context, listen: false);
      provider.loadSaintOfTheDay();
    });
  }

  @override
  void dispose() {
    // Directly close the provider's box without accessing context
    final provider = Provider.of<SaintOfTheDayProvider>(context, listen: false);
    provider.closeBox();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _refreshSaintOfTheDay() async {
    final provider = Provider.of<SaintOfTheDayProvider>(context, listen: false);
    provider.loadSaintOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SaintOfTheDayProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saint of the Day'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => provider.loadSaintOfTheDay(),
          ),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.saint == null
              ? const NoconnectionScreen()
              : RefreshIndicator(
                  onRefresh: _refreshSaintOfTheDay,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (provider.saint!.imageUrl.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  provider.saint!.imageUrl,
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
                                provider.saint!.saintName,
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
                                'Feast Day: ${provider.saint!.formattedDate}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                provider.saint!.description,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () =>
                                    _launchUrl(provider.saint!.link),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                ),
                                child: const Text('Read More'),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Last updated: ${provider.saint!.lastUpdated.toLocal()}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
