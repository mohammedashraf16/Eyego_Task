import 'package:eyego_task/core/database/api/api_consumer.dart';
import 'package:eyego_task/core/database/api/end_points.dart';
import 'package:eyego_task/features/products/data/models/product_model.dart';

class ProductRemoteDataSource {
  final ApiConsumer apiConsumer;
  ProductRemoteDataSource({required this.apiConsumer});
  Future<ProductsModel> getAllProducts() async {
    final respose = await apiConsumer.get(EndPoints.baseUrl);
    return ProductsModel.fromJson(respose);
  }

  Future<ProductsModel> searchProducts(String query) async {
    final response = await apiConsumer.get(
      EndPoints.search,
      queryParameters: {ApiKeys.query: query},
    );
    return ProductsModel.fromJson(response);
  }
}
