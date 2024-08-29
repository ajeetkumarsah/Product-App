// data/repositories/product_repository.dart
import 'package:product_app/data/api/api_service.dart';
import 'package:product_app/data/models/product_model.dart';
import 'package:product_app/utils/app_constants.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<List<ProductModel>> getProducts(int startIndex, int limit) {
    return apiService.fetchProducts(AppConstants.productUrl, startIndex, limit);
  }
}
