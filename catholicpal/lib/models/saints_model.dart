class Saint {
  final String name;
  final String imageUrl;
  final String description;

  Saint({
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  // Factory method to create a Saint object from a JSON map
  factory Saint.fromJson(Map<String, dynamic> json) {
    return Saint(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }
}
