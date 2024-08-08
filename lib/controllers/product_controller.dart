

import '../models/product.dart';

class ProductController {
  final List<Product> products = [
    Product(id: '0', name: 'Product #0', price: 1500000.0, imageUrl: 'assets/images/product_0.jpg'),
    Product(id: '1', name: 'Product #1', price: 160000.0, imageUrl: 'assets/images/product_1.jpg'),
    Product(id: '2', name: 'Product #2', price: 170000.0, imageUrl: 'assets/images/product_2.jpg'),
    Product(id: '3', name: 'Product #3', price: 180000.0, imageUrl: 'assets/images/product_3.jpg'),
    Product(id: '4', name: 'Product #4', price: 190000.0, imageUrl: 'assets/images/product_4.jpg'),
    Product(id: '5', name: 'Product #5', price: 100000000.0, imageUrl: 'assets/images/product_5.jpg', isHot: true),
    Product(id: '6', name: 'Product #6', price: 110000.0, imageUrl: 'assets/images/product_6.jpg', isHot: true),
    Product(id: '7', name: 'Product #7', price: 120000.0, imageUrl: 'assets/images/product_7.jpg', isHot: true),
    Product(id: '8', name: 'Product #8', price: 130000.0, imageUrl: 'assets/images/product_8.jpg', isHot: true),
    Product(id: '9', name: 'Product #9', price: 140000.0, imageUrl: 'assets/images/product_9.jpg', isHot: true),
  ];

  List<Product> get hotProducts =>
      products.where((product) => product.isHot).toList();

  List<Product> get allProducts => products;
}