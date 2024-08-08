import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/product/product_bloc.dart';
import 'blocs/product/product_event.dart';
import 'blocs/product/product_state.dart';
import 'controllers/product_controller.dart';
import 'views/home_screen.dart';
import 'views/splash_screen.dart';
import 'views/cart_screen.dart';
import 'blocs/cart/cart_bloc.dart';
import 'controllers/cart_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final cartController = CartController();
  final productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(cartController),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(productController)
            ..add(LoadProductsEvent()),
        ),
      ],
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductsAndHotProductsLoaded) {
          }
        },
        child: MaterialApp(
          title: 'Shopping Cart',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            '/home': (context) => HomeScreen(),
            '/cart': (context) => CartScreen(),
          },
        ),
      ),
    );
  }
}