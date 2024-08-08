

import '../../models/product.dart';

abstract class CartEvent {}

class AddProductEvent extends CartEvent {
  final Product product;
  final int quantity;

  AddProductEvent(this.product, this.quantity);
}

class RemoveProductEvent extends CartEvent {
  final Product product;

  RemoveProductEvent(this.product);
}

class ClearCartEvent extends CartEvent {}