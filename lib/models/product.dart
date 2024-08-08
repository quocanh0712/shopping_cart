

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final bool isHot;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isHot = false,
  });
}