import 'package:dio/dio.dart';
import 'package:project_structure_temp/core/errors/exceptions.dart';

class GlobalErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is NetworkException) {
      handler.next(err);
      return;
    }

    final errorType = err.type;

    switch (errorType) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        err = err.copyWith(error: const TimeoutException());
        break;

      case DioExceptionType.cancel:
        err = err.copyWith(error: const CancelledException());
        break;

      case DioExceptionType.unknown:
        if (err.error.toString().contains('SocketException')) {
          err = err.copyWith(error: const NoInternetException());
        } else {
          err = err.copyWith(error: const UnknownNetworkException());
        }
        break;

      default:
        err = err.copyWith(error: const UnknownNetworkException());
        break;
    }

    handler.next(err);
  }
}
