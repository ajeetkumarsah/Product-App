import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:product_app/data/models/product_model.dart';
import 'package:product_app/utils/app_constants.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<ProductModel>> fetchProducts(
      String url, int startIndex, int limit) async {
    try {
      final response =
          await _dio.get(AppConstants.baseUrl + url, queryParameters: {
        '_start': startIndex,
        '_limit': limit,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        debugPrint('===>Response : ${data.length}');

        // Mapping the list of dynamic to List<ProductModel>
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
