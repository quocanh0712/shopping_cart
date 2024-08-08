import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import '../models/product.dart';
import '../views/product_bottom_sheet.dart';

class HotProductItem extends StatelessWidget {
  final Product product;

  HotProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    ).format(product.price).replaceAll('.', ',');

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => ProductBottomSheet(product: product),
        );
      },
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    product.imageUrl,
                    height: 150,
                    width: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '🔥',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 20,
                        width: 80,
                        child: formattedPrice.length > 10
                            ? Marquee(
                          text: formattedPrice,
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                          scrollAxis: Axis.horizontal,
                          blankSpace: 20.0,
                          velocity: 30.0,
                          startPadding: 10.0,
                          accelerationDuration: Duration(seconds: 1),
                          accelerationCurve: Curves.easeIn,
                          decelerationDuration: Duration(seconds: 1),
                          decelerationCurve: Curves.easeOut,
                        )
                            : Text(
                          formattedPrice,
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.add_shopping_cart, color: Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}