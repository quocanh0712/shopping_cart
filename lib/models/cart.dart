

import 'package:shopping_cart/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class Cart {
  final List<CartItem> items;

  Cart({this.items = const []});
}