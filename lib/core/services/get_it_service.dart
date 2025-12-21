import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eyego_task/core/connection/network_info.dart';
import 'package:eyego_task/core/database/api/api_consumer.dart';
import 'package:eyego_task/core/database/api/dio_consumer.dart';
import 'package:eyego_task/core/database/cache/cache_helper.dart';
import 'package:eyego_task/features/products/data/data_source/product_local_data_source.dart';
import 'package:eyego_task/features/products/data/data_source/product_remote_data_source.dart';
import 'package:eyego_task/features/products/data/repos/product_repo_impl.dart';
import 'package:eyego_task/features/products/domain/repos/product_repo.dart';
import 'package:eyego_task/features/products/domain/usecases/get_products_usecase.dart';
import 'package:eyego_task/features/products/presentation/manager/product_cubit.dart';
import 'package:get_it/get_it.dart';

final s1 = GetIt.instance;
void setupServiceLocator() {
  // product cubit
  s1.registerFactory(() => ProductCubit(getProductsUsecase: s1()));
  // usecase
  s1.registerLazySingleton(() => GetProductsUsecase(productRepo: s1()));

  // repository
  s1.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(
      networkInfo: s1(),
      remoteDataSource: s1(),
      localDataSource: s1(),
    ),
  );
  // data sources
  s1.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(apiConsumer: s1()),
  );
  s1.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSource(cacheHelper: s1()),
  );
  // core
  s1.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(s1()));
  s1.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: s1()));
  // external
  s1.registerLazySingleton(() => Dio());
  s1.registerLazySingleton(() => CacheHelper());
  s1.registerLazySingleton(() => DataConnectionChecker());
}
