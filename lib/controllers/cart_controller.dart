

import '../models/cart.dart';
import '../models/product.dart';

class CartController {
  Cart _cart = Cart();

  Cart get cart => _cart;

  void addProduct(Product product, int quantity) {
    final existingItem = _cart.items.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      _cart.items.add(CartItem(product: product, quantity: quantity));
    } else {
      existingItem.quantity += quantity;
    }
  }

  void removeProduct(Product product) {
    _cart.items.removeWhere((item) => item.product.id == product.id);
  }

  void clearCart() {
    _cart.items.clear();
  }

  double get totalAmount {
    return _cart.items.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  }
}