

import '../../models/cart.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final Cart cart;

  CartUpdated({required this.cart});
}

class CartCleared extends CartState {}