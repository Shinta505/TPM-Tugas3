class WatchModel {
  final String style;
  final String gender;
  final double caseDiameter;
  final String caseMaterial;
  final String strapMaterial;
  final String model;
  final String brand;
  final List<String> color;
  final int weight;
  final int price;
  final String imageUrl;
  final String websiteUrl;
  bool isFavorite;

  WatchModel({
    required this.style,
    required this.gender,
    required this.caseDiameter,
    required this.caseMaterial,
    required this.strapMaterial,
    required this.model,
    required this.brand,
    required this.color,
    required this.weight,
    required this.price,
    required this.imageUrl,
    required this.websiteUrl,
    this.isFavorite = false,
  });
}
