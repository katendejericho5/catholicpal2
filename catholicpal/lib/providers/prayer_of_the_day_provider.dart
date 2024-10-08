import 'package:catholicpal/models/prayer_of_the_day.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class PrayerOfTheDayProvider extends ChangeNotifier {
  Box<PrayerOfTheDay>? prayerBox;
  PrayerOfTheDay? prayerOfTheDay;
  bool isLoading = true;

  PrayerOfTheDayProvider() {
    _openHiveBox().then((_) {
      loadPrayerOfTheDay();
    });
  }

  Future<void> _openHiveBox() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PrayerOfTheDayAdapter());
    }
    prayerBox = await Hive.openBox<PrayerOfTheDay>('prayerOfTheDay');
  }

  Future<void> loadPrayerOfTheDay() async {
    isLoading = true;
    notifyListeners();

    try {
      PrayerOfTheDay? cachedPrayer = await _getCachedPrayerOfTheDay();

      if (cachedPrayer != null) {
        prayerOfTheDay = cachedPrayer;
      } else {
        PrayerOfTheDay fetchedPrayer = await _fetchFromNetwork();
        await _savePrayerOfTheDay(fetchedPrayer);
        prayerOfTheDay = fetchedPrayer;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching prayer: $e');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<PrayerOfTheDay?> _getCachedPrayerOfTheDay() async {
    if (prayerBox != null && prayerBox!.isNotEmpty) {
      return prayerBox!.getAt(0);
    }
    return null;
  }

  Future<void> _savePrayerOfTheDay(PrayerOfTheDay prayer) async {
    await prayerBox?.put(0, prayer);
  }

  Future<PrayerOfTheDay> _fetchFromNetwork() async {
    final response =
        await http.get(Uri.parse('https://www.catholic.org/xml/rss_pofd.php'));

    if (response.statusCode == 200) {
      var rawXml = xml.XmlDocument.parse(response.body);
      var item = rawXml.findAllElements('item').first;
      return PrayerOfTheDay.fromXml(item);
    } else {
      throw Exception('Failed to load Prayer of the Day');
    }
  }

  /// Close the Hive box when it's no longer needed
  Future<void> closeBox() async {
    if (prayerBox != null) {
      await prayerBox!.close();
      prayerBox = null;
      notifyListeners(); // Notify listeners in case you need to update UI after closing
    }
  }
}
