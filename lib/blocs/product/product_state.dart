import '../../models/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductsAndHotProductsLoaded extends ProductState {
  final List<Product> products;
  final List<Product> hotProducts;

  ProductsAndHotProductsLoaded({required this.products, required this.hotProducts});
}