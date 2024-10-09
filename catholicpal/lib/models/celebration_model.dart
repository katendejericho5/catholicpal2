class Celebration {
  final String title;
  final String colour;
  final String rank;
  final double rankNum;

  Celebration({
    required this.title,
    required this.colour,
    required this.rank,
    required this.rankNum,
  });

  factory Celebration.fromJson(Map<String, dynamic> json) {
    return Celebration(
      title: json['title'],
      colour: json['colour'],
      rank: json['rank'],
      rankNum: json['rank_num'].toDouble(),
    );
  }
}
