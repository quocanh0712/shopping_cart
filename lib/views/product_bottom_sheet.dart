import 'package:flutter/material.dart';
import '../blocs/cart/cart_event.dart';
import '../models/product.dart';
import '../blocs/cart/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductBottomSheet extends StatefulWidget {
  final Product product;

  ProductBottomSheet({required this.product});

  @override
  _ProductBottomSheetState createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {

    final formattedPrice = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    ).format(widget.product.price).replaceAll('.', ',');

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    widget.product.imageUrl,
                    height: 95,
                    width: 95,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),

                            borderRadius:
                                BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: quantity > 1
                                    ? () => setState(() => quantity--)
                                    : null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  child: Icon(Icons.remove),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final newQuantity = await showDialog<int>(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController quantityController =
                                          TextEditingController(
                                              text: quantity.toString());
                                      bool isInvalid = false;

                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                              padding: EdgeInsets.all(16),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Center(
                                                    child: Text(
                                                      widget.product.name,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  TextField(
                                                    controller:
                                                        quantityController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                          ),
                                                      hintText:
                                                          'Enter quantity',
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide(
                                                          color: isInvalid
                                                              ? Colors.red
                                                              : Colors.orange,
                                                          width: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        final int?
                                                            enteredQuantity =
                                                            int.tryParse(value);
                                                        isInvalid =
                                                            enteredQuantity !=
                                                                    null &&
                                                                enteredQuantity >
                                                                    999;
                                                      });
                                                    },
                                                  ),
                                                  if (isInvalid) ...[
                                                    SizedBox(height: 10),
                                                    Text(
                                                      'Quantity cannot exceed 999',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 14, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                  SizedBox(height: 21),
                                                  GestureDetector(
                                                    onTap: () {
                                                      final int?
                                                          enteredQuantity =
                                                          int.tryParse(
                                                              quantityController
                                                                  .text);
                                                      if (enteredQuantity !=
                                                              null &&
                                                          enteredQuantity > 0 &&
                                                          enteredQuantity <=
                                                              999) {
                                                        Navigator.of(context)
                                                            .pop(
                                                                enteredQuantity);
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15,
                                                              horizontal: 30),
                                                      decoration: BoxDecoration(
                                                        color: isInvalid
                                                            ? Colors.grey
                                                            : Colors.orange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Submit',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                  if (newQuantity != null) {
                                    setState(() {
                                      quantity = newQuantity;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Text(
                                    '$quantity',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: quantity < 999
                                    ? () => setState(() => quantity++)
                                    : null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          formattedPrice,
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 35),
          GestureDetector(
            onTap: () {
              context
                  .read<CartBloc>()
                  .add(AddProductEvent(widget.product, quantity));
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 130),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Add to cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
