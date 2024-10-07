import 'package:catholicpal/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:catholicpal/models/bible_model/verse.dart';
import 'package:catholicpal/providers/app_provider.dart';
import 'package:catholicpal/screens/home/home_page.dart';
import 'package:catholicpal/services/bible_services/fetch_books.dart';
import 'package:catholicpal/services/bible_services/fetch_verses.dart';
import 'package:catholicpal/services/bible_services/save_current_index.dart';

// Import your SaintOfTheDay and PrayerOfTheDay models
import 'package:catholicpal/models/saint_of_day.dart';
import 'package:catholicpal/models/prayer_of_the_day.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // Register the adapters
  Hive.registerAdapter(SaintOfTheDayAdapter());
  Hive.registerAdapter(PrayerOfTheDayAdapter());
  Hive.registerAdapter(DailyNewsAdapter());

  // Open the boxes
  await Hive.openBox<SaintOfTheDay>('saintOfTheDay');
  await Hive.openBox<PrayerOfTheDay>(
      'prayerOfTheDay'); // Add this for PrayerOfTheDay
  await Hive.openBox<DailyNews>('dailyNews');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Box<SaintOfTheDay> saintBox;
  late Box<PrayerOfTheDay> prayerBox; // Add this for PrayerOfTheDay
  late Box<DailyNews> newsBox;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    saintBox = Hive.box<SaintOfTheDay>('saintOfTheDay');
    prayerBox = Hive.box<PrayerOfTheDay>(
        'prayerOfTheDay'); // Initialize the PrayerOfTheDay box
    newsBox = Hive.box<DailyNews>('dailyNews');

    Future.delayed(
      const Duration(milliseconds: 100),
      () async {
        MainProvider mainProvider =
            Provider.of<MainProvider>(context, listen: false);
        mainProvider.itemPositionsListener.itemPositions.addListener(
          () {
            int index = mainProvider
                .itemPositionsListener.itemPositions.value.last.index;

            SaveCurrentIndex.execute(
                index: mainProvider
                    .itemPositionsListener.itemPositions.value.first.index);

            Verse currentVerse = mainProvider.verses[index];

            if (mainProvider.currentVerse == null) {
              mainProvider.updateCurrentVerse(verse: mainProvider.verses.first);
            }

            Verse previousVerse = mainProvider.currentVerse == null
                ? mainProvider.verses.first
                : mainProvider.currentVerse!;

            if (currentVerse.book != previousVerse.book) {
              mainProvider.updateCurrentVerse(verse: currentVerse);
            }
          },
        );
        await FetchVerses.execute(mainProvider: mainProvider).then(
          (_) async {
            await FetchBooks.execute(mainProvider: mainProvider)
                .then((_) => setState(() {}));
          },
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is in background
      _closeHiveBox();
    } else if (state == AppLifecycleState.resumed) {
      // App is in foreground
      _openHiveBox();
    }
  }

  Future<void> _closeHiveBox() async {
    if (saintBox.isOpen) {
      await saintBox.compact();
      await saintBox.close();
    }

    if (prayerBox.isOpen) {
      await prayerBox.compact();
      await prayerBox.close();
    }

    if (newsBox.isOpen) {
      await newsBox.compact();
      await newsBox.close();
    }
  }

  Future<void> _openHiveBox() async {
    if (!saintBox.isOpen) {
      saintBox = await Hive.openBox<SaintOfTheDay>('saintOfTheDay');
    }

    if (!prayerBox.isOpen) {
      prayerBox = await Hive.openBox<PrayerOfTheDay>('prayerOfTheDay');
    }
    if (!newsBox.isOpen) {
      newsBox = await Hive.openBox<DailyNews>('dailyNews');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CatholicPal',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorSchemeSeed: Colors.brown,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.brown,
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}
