import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:catholicpal/models/saint_of_day.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SaintOfTheDayProvider extends ChangeNotifier {
  Box<SaintOfTheDay>? saintBox;
  bool isLoading = true;
  String errorMessage = '';

  SaintOfTheDayProvider() {
    initHive();
  }

  Future<void> initHive() async {
    try {
      saintBox = await Hive.openBox<SaintOfTheDay>('saintOfTheDay');
      await loadSaintOfTheDay();
    } catch (e) {
      errorMessage = 'Failed to initialize: $e';
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSaintOfTheDay() async {
    if (saintBox == null) return;

    isLoading = true;
    notifyListeners();

    try {
      SaintOfTheDay? cachedSaint = saintBox!.get('current');
      if (cachedSaint != null) {
        isLoading = false;
        notifyListeners();
      }

      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        await updateSaintOfTheDay();
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
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
        notifyListeners(); // Trigger a rebuild to show updated data
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

  SaintOfTheDay? get saint {
    return saintBox?.get('current');
  }
  // closing box
  Future<void> closeBox() async {
    if (saintBox != null) {
      await saintBox!.close();
      saintBox = null;
      notifyListeners(); // Notify listeners in case you need to update UI after closing
    }
  }
}
