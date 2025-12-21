import 'dart:convert';

import 'package:eyego_task/core/database/cache/cache_helper.dart';
import 'package:eyego_task/core/errors/exceptions.dart';
import 'package:eyego_task/features/products/data/models/product_model.dart';

class ProductLocalDataSource {
  final CacheHelper cacheHelper;
  final String key = 'CACHED_PRODUCTS';
  ProductLocalDataSource({required this.cacheHelper});
  Future<void> cacheProducts(ProductsModel? productModel) async {
    if (productModel != null) {
      await cacheHelper.saveData(
        key: key,
        value: json.encode(productModel.toJson()),
      );
    } else {
      throw CacheException(
        errorMessage: "No Internet connection and no cached data available",
      );
    }
  }

  Future<ProductsModel> getLastProducts() async {
    final jsonString = cacheHelper.getData(key: key);
    if (jsonString != null) {
      return ProductsModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(
        errorMessage: "No Internet connection and no cached data available",
      );
    }
  }
}
