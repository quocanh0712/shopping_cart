

import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../controllers/cart_controller.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartController _cartController;

  CartBloc(this._cartController) : super(CartInitial()) {
    on<AddProductEvent>((event, emit) {
      _cartController.addProduct(event.product, event.quantity);
      emit(CartUpdated(cart: _cartController.cart));
    });

    on<RemoveProductEvent>((event, emit) {
      _cartController.removeProduct(event.product);
      emit(CartUpdated(cart: _cartController.cart));
    });

    on<ClearCartEvent>((event, emit) {
      _cartController.clearCart();
      emit(CartCleared());
    });
  }
}