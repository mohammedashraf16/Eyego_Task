import 'package:dio/dio.dart';
import 'package:eyego_task/core/database/api/end_points.dart';
import 'package:eyego_task/core/database/cache/cache_helper.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKeys.token] =
        CacheHelper().getDataString(key: ApiKeys.token) != null
        ? CacheHelper().getDataString(key: ApiKeys.token)
        : null;
    super.onRequest(options, handler);
  }
}
