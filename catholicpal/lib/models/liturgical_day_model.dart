import 'package:catholicpal/models/celebration_model.dart';

class LiturgicalDay {
  final DateTime date;
  final String season;
  final int seasonWeek;
  final String weekday;
  final List<Celebration> celebrations;

  LiturgicalDay({
    required this.date,
    required this.season,
    required this.seasonWeek,
    required this.weekday,
    required this.celebrations,
  });

  factory LiturgicalDay.fromJson(Map<String, dynamic> json) {
    return LiturgicalDay(
      date: DateTime.parse(json['date']),
      season: json['season'],
      seasonWeek: json['season_week'],
      weekday: json['weekday'],
      celebrations: (json['celebrations'] as List)
          .map((celebration) => Celebration.fromJson(celebration))
          .toList(),
    );
  }
}
