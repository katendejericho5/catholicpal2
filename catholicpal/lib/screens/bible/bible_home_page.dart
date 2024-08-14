import 'package:catholicpal/models/bible_model/verse.dart';
import 'package:catholicpal/providers/app_provider.dart';
import 'package:catholicpal/screens/bible/books_page.dart';
import 'package:catholicpal/screens/bible/search_page.dart';
import 'package:catholicpal/screens/widgets/verse_widget.dart';
import 'package:catholicpal/services/bible_services/read_last_index.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BibleHomePage extends StatefulWidget {
  const BibleHomePage({super.key});

  @override
  State<BibleHomePage> createState() => _BibleHomePageState();
}

class _BibleHomePageState extends State<BibleHomePage> {
  @override
  void initState() {
    // We will resume to the last position the user was
    // Delayed execution to allow the UI to build before scrolling
    Future.delayed(
      const Duration(milliseconds: 100),
      () async {
        MainProvider mainProvider =
            Provider.of<MainProvider>(context, listen: false);

        // Read the last index and scroll to it
        await ReadLastIndex.execute().then(
          (index) {
            if (index != null) {
              mainProvider.scrollToIndex(index: index);
            }
          },
        );
      },
    );
    super.initState();
  }

  // Process selected verses to create a formatted string
  String formattedSelectedVerses({required List<Verse> verses}) {
    String result = verses
        .map((e) => " [${e.book} ${e.chapter}:${e.verse}] ${e.text.trim()}")
        .join();

    return "$result [KJV]";
  }

  // Using Consumer to listen to changes in MainProvider
  @override
  Widget build(BuildContext context) {
    // Using Consumer to listen to changes in MainProvider
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Consumer<MainProvider>(
        builder: (context, mainProvider, child) {
          List<Verse> verses = mainProvider.verses;
          Verse? currentVerse =
              mainProvider.currentVerse; // Make currentVerse nullable
          bool isSelected = mainProvider.selectedVerses.isNotEmpty;

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              systemNavigationBarColor: Theme.of(context).colorScheme.surface,
              systemNavigationBarIconBrightness:
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: isSelected
                    ? null
                    : GestureDetector(
                        onTap: () {
                          // Navigate to BooksPage on tap
                          if (currentVerse != null) {
                            Get.to(
                              () => BooksPage(
                                chapterIdx: currentVerse.chapter,
                                bookIdx: currentVerse.book,
                              ),
                              transition: Transition.leftToRight,
                            );
                          }
                        },
                        child: Text(currentVerse?.book ?? ''),
                      ),
                actions: [
                  if (isSelected)
                    IconButton(
                      onPressed: () async {
                        // Copy selected verses to clipboard
                        String string = formattedSelectedVerses(
                            verses: mainProvider.selectedVerses);
                        await FlutterClipboard.copy(string).then(
                          (_) => mainProvider.clearSelectedVerses(),
                        );
                      },
                      icon: const Icon(
                        Icons.copy_rounded,
                      ),
                    ),
                  if (!isSelected)
                    IconButton(
                      onPressed: () async {
                        /// Navigate to [SearchPage] on tap
                        Get.to(
                          () => SearchPage(verses: verses),
                          transition: Transition.rightToLeft,
                        );
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                      ),
                    ),
                ],
              ),
              // Body of the Scaffold with a ScrollablePositionedList
              body: ScrollablePositionedList.builder(
                itemCount: verses.length,
                itemBuilder: (context, index) {
                  Verse verse = verses[index];
                  return VerseWidget(verse: verse, index: index);
                },
                itemScrollController: mainProvider.itemScrollController,
                itemPositionsListener: mainProvider.itemPositionsListener,
                scrollOffsetController: mainProvider.scrollOffsetController,
                scrollOffsetListener: mainProvider.scrollOffsetListener,
              ),
            ),
          );
        },
      ),
    );
  }
}
