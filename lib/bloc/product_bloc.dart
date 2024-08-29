import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/data/models/product_model.dart';
import 'package:product_app/data/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  List<ProductModel> likedProducts = [];
  final bool _hasMoreProducts = true;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<ToggleFavoriteStatus>(_onToggleFavoriteStatus);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    debugPrint('===>Product fetch');

    try {
      if (state is ProductLoading) return;

      // Emit loading state if this is the first page
      if (event.offset == 0) {
        emit(ProductLoading());
      }

      final List<ProductModel> products =
          await productRepository.getProducts(event.offset, event.limit);

      // Determine if there are more products to load
      // _hasMoreProducts = products.length == event.limit;

      // Emit new state with the fetched products
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(currentState.products + products, _hasMoreProducts,
            likedProducts: likedProducts));
      } else {
        emit(ProductLoaded(products, _hasMoreProducts,
            likedProducts: likedProducts));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onToggleFavoriteStatus(
      ToggleFavoriteStatus event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final updatedProducts = (state as ProductLoaded).products.map((product) {
        if (product.id == event.productId) {
          final isLiked = !product.isFavorite;
          if (isLiked) {
            likedProducts.add(product.copyWith(isFavorite: true));
          } else {
            likedProducts.removeWhere((p) => p.id == product.id);
          }
          return product.copyWith(isFavorite: isLiked);
        }
        return product;
      }).toList();
      emit(ProductLoaded(updatedProducts, _hasMoreProducts,
          likedProducts: likedProducts));
    }
  }
}
