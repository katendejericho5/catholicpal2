import 'package:catholicpal/providers/daily_reading_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

class DailyReadingsPage extends StatefulWidget {
  const DailyReadingsPage({super.key});

  @override
  State<DailyReadingsPage> createState() => _DailyReadingsPageState();
}

class _DailyReadingsPageState extends State<DailyReadingsPage> {
  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to call loadDailyReading after the current frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DailyReadingProvider>(context, listen: false);
      provider.loadDailyReading();
    });
  }

  @override
  void dispose() {
    final provider = Provider.of<DailyReadingProvider>(context, listen: false);
    provider.closeBox();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DailyReadingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Readings'),
        elevation: 0,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage.isNotEmpty
              ? Center(child: Text(provider.errorMessage))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.currentReading?.title ?? 'No Title',
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
                          'Published: ${provider.currentReading?.formattedDate ?? ''}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Html(
                          data: provider.currentReading?.description ?? '',
                          style: {
                            "body": Style(fontSize: FontSize(16)),
                            "h4": Style(color: Theme.of(context).primaryColor),
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              _launchUrl(provider.currentReading?.link ?? ''),
                          child: const Text('Read More'),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }
}
