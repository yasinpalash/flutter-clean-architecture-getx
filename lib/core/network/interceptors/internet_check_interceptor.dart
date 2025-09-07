import 'package:dio/dio.dart';
import 'package:project_structure_temp/core/errors/exceptions.dart';
import 'package:project_structure_temp/core/services/network_checker.dart';

class InternetCheckInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final hasInternet = await NetworkChecker.isConnected();
    if (!hasInternet) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: const NoInternetException(),
          type: DioExceptionType.unknown,
        ),
        true,
      );
    } else {
      handler.next(options);
    }
  }
}
