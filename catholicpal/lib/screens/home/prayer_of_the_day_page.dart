import 'package:cached_network_image/cached_network_image.dart';
import 'package:catholicpal/providers/prayer_of_the_day_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PrayerOfTheDayPage extends StatefulWidget {
  const PrayerOfTheDayPage({super.key});

  @override
  State<PrayerOfTheDayPage> createState() => _PrayerOfTheDayPageState();
}

class _PrayerOfTheDayPageState extends State<PrayerOfTheDayPage> {
  @override
  void initState() {
    super.initState();
    final provider =
        Provider.of<PrayerOfTheDayProvider>(context, listen: false);
    provider.loadPrayerOfTheDay();
  }

  @override
  void dispose() {
    final provider =
        Provider.of<PrayerOfTheDayProvider>(context, listen: false);
    provider.closeBox();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prayerProvider = Provider.of<PrayerOfTheDayProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer of the Day'),
        elevation: 0,
      ),
      body: prayerProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : prayerProvider.prayerOfTheDay != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              getImageUrl(),
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
                              prayerProvider.prayerOfTheDay!.title,
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
                              'Published: ${prayerProvider.prayerOfTheDay!.formattedDate}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              prayerProvider.prayerOfTheDay!.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _launchUrl(
                                  prayerProvider.prayerOfTheDay?.link ?? ''),
                              child: const Text('Read More'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: Text('No data available')),
    );
  }

  String getImageUrl() {
    return 'https://images.pexels.com/photos/1615776/pexels-photo-1615776.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $url';
    }
  }
}
