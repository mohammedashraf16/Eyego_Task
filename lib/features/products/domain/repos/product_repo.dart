import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failure.dart';
import 'package:eyego_task/features/products/data/models/product_model.dart';

abstract class ProductRepo {
  Future<Either<Failure, ProductsModel>> getAllProducts();
}
