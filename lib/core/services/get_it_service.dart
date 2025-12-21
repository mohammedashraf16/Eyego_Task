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

final sl = GetIt.instance;
void setupServiceLocator() {
  // product cubit
  sl.registerFactory(
    () => ProductCubit(getProductsUsecase: sl(), searchProductsUsecase: sl()),
  );
  // usecase
  sl.registerLazySingleton(() => GetProductsUsecase(productRepo: sl()));
  sl.registerLazySingleton(() => SearchProductsUsecase(productRepo: sl()));

  // repository
  sl.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  // data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(apiConsumer: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSource(cacheHelper: sl()),
  );
  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  // external
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => CacheHelper());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
