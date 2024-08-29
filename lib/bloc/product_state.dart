// logic/bloc/product_state.dart
import 'package:equatable/equatable.dart';
import 'package:product_app/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<ProductModel> likedProducts;
  final bool hasMoreProducts;

  ProductLoaded(this.products, this.hasMoreProducts,
      {this.likedProducts = const []});

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
