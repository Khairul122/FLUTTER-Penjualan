part of rest_api_service;

class Etalase {
  final String id;
  final List<ImageProvider> images;
  final String name;
  final double price;
  final bool isFavorite;
  final String description;

  const Etalase({
    required this.id,
    required this.images,
    required this.name,
    required this.price,
    required this.isFavorite,
    required this.description,
  });
}