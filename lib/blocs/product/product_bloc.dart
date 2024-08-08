import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../controllers/product_controller.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductController _productController;

  ProductBloc(this._productController) : super(ProductInitial()) {
    on<LoadProductsEvent>((event, emit) {
      final products = _productController.allProducts;
      final hotProducts = _productController.hotProducts;
      emit(ProductsAndHotProductsLoaded(products: products, hotProducts: hotProducts));
    });
  }
}