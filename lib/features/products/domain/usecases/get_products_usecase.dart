import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failure.dart';
import 'package:eyego_task/features/products/data/models/product_model.dart';
import 'package:eyego_task/features/products/domain/repos/product_repo.dart';

class GetProductsUsecase {
  final ProductRepo productRepo;
  GetProductsUsecase({required this.productRepo});
  Future<Either<Failure, ProductsModel>> call() async {
    return await productRepo.getAllProducts();
  }
}

class SearchProductsUsecase {
  final ProductRepo productRepo;
  SearchProductsUsecase({required this.productRepo});

  Future<Either<Failure, ProductsModel>> call(String query) async {
    return await productRepo.searchProducts(query);
  }
}
