import 'package:catholicpal/models/church_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChurchService {
  final String apiUrl = 'https://your-api-endpoint.com/churches';

  Future<List<Church>> getNearbyChurches(
      double latitude, double longitude, double radius) async {
    final response = await http
        .get(Uri.parse('$apiUrl?lat=$latitude&lon=$longitude&radius=$radius'));

    if (response.statusCode == 200) {
      List<dynamic> churchesJson = json.decode(response.body);
      return churchesJson.map((json) => Church.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load churches');
    }
  }

  Future<Position> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
