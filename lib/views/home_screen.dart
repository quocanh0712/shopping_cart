import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_state.dart';
import '../widgets/product_item.dart';
import '../widgets/hot_product_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Home', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int itemCount = 0;
              if (state is CartUpdated) {
                itemCount = state.cart.items.length;
              }
              return IconButton(
                icon: Stack(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.white,),
                    if (itemCount > 0)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            itemCount.toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'HOT Products 🔥',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ),
            Container(
              height: 225,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductsAndHotProductsLoaded) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.hotProducts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.only(left: 18.0, right: 5),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: HotProductItem(product: state.hotProducts[index]),
                          ),
                        );
                      },
                    );
                  } else if (state is ProductInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(child: Text('Failed to load products.'));
                  }
                },
              ),
            ),

            Padding(
              padding:  EdgeInsets.all(16.0),
              child: Text(
                'All Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductsAndHotProductsLoaded) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3/4,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                        child: ProductItem(product: state.products[index]),
                      );
                    },
                  );
                } else if (state is ProductInitial) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text('Failed to load products.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}