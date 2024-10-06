import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomWebView extends StatefulWidget {
  final String initialUrl;
  final List<String> adUrlFilters;

  const CustomWebView({
    super.key,
    required this.initialUrl,
    required this.adUrlFilters,
  });

  @override
  CustomWebViewState createState() => CustomWebViewState();
}

class CustomWebViewState extends State<CustomWebView> {
  late List<ContentBlocker> contentBlockers;
  bool contentBlockerEnabled = true;
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();

    // Initialize content blockers
    contentBlockers = widget.adUrlFilters.map((filter) {
      return ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: filter,
        ),
        action: ContentBlockerAction(
          type: ContentBlockerActionType.BLOCK,
        ),
      );
    }).toList();

    // Add CSS rules to hide certain elements
    contentBlockers.add(ContentBlocker(
      trigger: ContentBlockerTrigger(urlFilter: ".*"),
      action: ContentBlockerAction(
        type: ContentBlockerActionType.CSS_DISPLAY_NONE,
        selector: ".banner, .banners, .ads, .ad, .advert",
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom WebView"),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() {
                contentBlockerEnabled = !contentBlockerEnabled;
              });
              if (contentBlockerEnabled) {
                await webViewController?.setSettings(
                  settings:
                      InAppWebViewSettings(contentBlockers: contentBlockers),
                );
              } else {
                await webViewController?.setSettings(
                  settings: InAppWebViewSettings(contentBlockers: []),
                );
              }
              webViewController?.reload();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: Text(contentBlockerEnabled ? 'Disable' : 'Enable'),
          )
        ],
      ),
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
          initialSettings:
              InAppWebViewSettings(contentBlockers: contentBlockers),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
        ),
      ),
    );
  }
}
