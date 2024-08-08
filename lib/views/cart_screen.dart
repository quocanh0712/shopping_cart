

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../widgets/product_item.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated && state.cart.items.isNotEmpty) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cart.items[index];
                      return ListTile(
                        title: Text(cartItem.product.name),
                        subtitle: Text('${cartItem.product.price} x ${cartItem.quantity}'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            context
                                .read<CartBloc>()
                                .add(RemoveProductEvent(cartItem.product));
                          },
                        ),
                      );
                    },
                  ),
                ),
                Text(
                'Total: \$${state.cart.items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity)}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text('Order'),
                  onPressed: () {
                    context.read<CartBloc>().add(ClearCartEvent());
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Order Success'),
                        content: Text('Your order has been placed successfully!'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamedAndRemoveUntil('/home', (route) => false),
                            child: Text('Back to Home'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
              ],
            );
          } else {
            return Center(
              child: Text('Your cart is empty.'),
            );
          }
        },
      ),
    );
  }
}