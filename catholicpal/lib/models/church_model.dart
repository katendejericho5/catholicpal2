class Church {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String description;

  Church({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.description,
  });

  factory Church.fromJson(Map<String, dynamic> json) {
    return Church(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
    };
  }
}