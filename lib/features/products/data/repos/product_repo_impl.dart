import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/connection/network_info.dart';
import 'package:eyego_task/core/errors/exceptions.dart';
import 'package:eyego_task/core/errors/failure.dart';
import 'package:eyego_task/features/products/data/data_source/product_local_data_source.dart';
import 'package:eyego_task/features/products/data/data_source/product_remote_data_source.dart';
import 'package:eyego_task/features/products/data/models/product_model.dart';
import 'package:eyego_task/features/products/domain/repos/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final NetworkInfo networkInfo;
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepoImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ProductsModel>> getAllProducts() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(Failure(errorMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        final localProducts = await localDataSource.getLastProducts();
        return Right(localProducts);
      } on CacheException catch (e) {
        return Left(Failure(errorMessage: e.errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, ProductsModel>> searchProducts(String query) async {
    if (await networkInfo.isConnected!) {
      try {
        final searchResults = await remoteDataSource.searchProducts(query);
        return Right(searchResults);
      } on ServerException catch (e) {
        return Left(Failure(errorMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errorMessage: "No internet connection"));
    }
  }
}
