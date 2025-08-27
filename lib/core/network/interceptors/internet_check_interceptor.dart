import 'package:dio/dio.dart';
import '../../errors/exceptions.dart';
import '../../services/network_checker.dart';

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
          error: NoInternetException(),
          type: DioExceptionType.unknown,
        ),
        true,
      );
    } else {
      handler.next(options);
    }
  }
}
