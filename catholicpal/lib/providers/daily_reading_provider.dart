import 'package:catholicpal/models/daily_reading.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:connectivity_plus/connectivity_plus.dart';

class DailyReadingProvider with ChangeNotifier {
  Box<DailyReading>? readingBox;
  bool isLoading = true;
  String errorMessage = '';

  DailyReadingProvider() {
    initHive();
  }

  Future<void> initHive() async {
    try {
      readingBox = await Hive.openBox<DailyReading>('dailyReading');
      await loadDailyReading();
    } catch (e) {
      errorMessage = 'Failed to initialize: $e';
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDailyReading() async {
    if (readingBox == null) return;

    isLoading = true;
    notifyListeners();

    try {
      DailyReading? cachedReading = readingBox!.get('current');
      if (cachedReading != null) {
        isLoading = false;
        notifyListeners();
      }

      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        await updateDailyReading();
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDailyReading() async {
    if (readingBox == null) return;

    try {
      final response =
          await http.get(Uri.parse('https://bible.usccb.org/readings.rss'));
      if (response.statusCode == 200) {
        var raw = xml.XmlDocument.parse(response.body);
        var element = raw.findAllElements('item').first;
        final reading = DailyReading.fromXml(element);

        await readingBox!.put('current', reading);
        notifyListeners(); // Notify listeners to rebuild widgets
      } else {
        throw Exception('Failed to load Daily Reading');
      }
    } catch (e) {
      errorMessage = 'Error updating Daily Reading: $e';
      notifyListeners();
    }
  }

  DailyReading? get currentReading => readingBox?.get('current');

  /// Close the Hive box when it's no longer needed
  Future<void> closeBox() async {
    if (readingBox != null) {
      await readingBox!.close();
      readingBox = null;
      notifyListeners(); // Notify listeners in case you need to update UI after closing
    }
  }
}
