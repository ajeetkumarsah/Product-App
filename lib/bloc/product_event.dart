// logic/bloc/product_event.dart
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductEvent {
  final int offset;
  final int limit;

  FetchProducts(this.offset, {this.limit = 20});

  @override
  List<Object?> get props => [offset, limit];
}

class ToggleFavoriteStatus extends ProductEvent {
  final int productId;

  ToggleFavoriteStatus(this.productId);

  @override
  List<Object?> get props => [productId];
}
