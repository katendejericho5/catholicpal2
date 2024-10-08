class Prayer {
  final String id;
  final String categoryId;
  final String name;
  final String iconAssetUrl;
  final String details;

  Prayer({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.iconAssetUrl,
    required this.details,
  });

  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      iconAssetUrl: json['iconAssetUrl'] as String,
      details: json['details'] as String,
    );
  }
}
