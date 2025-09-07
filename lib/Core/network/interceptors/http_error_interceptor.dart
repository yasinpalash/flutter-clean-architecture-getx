import 'package:dio/dio.dart';
import 'package:project_structure_temp/core/errors/exceptions.dart';

class HttpErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;

    if (statusCode != null) {
      switch (statusCode) {
        // 2xx: Successful responses (normally not errors, but listed for clarity)
        case 204:
          err = err.copyWith(error: const NetworkException("No Content"));
          break;

        // 3xx: Redirection (handle as needed)
        case 301:
          err =
              err.copyWith(error: const NetworkException("Moved Permanently"));
          break;
        case 302:
          err = err.copyWith(error: const NetworkException("Found (Redirect)"));
          break;
        case 304:
          err = err.copyWith(error: const NetworkException("Not Modified"));
          break;

        // 4xx: Client Errors
        case 400:
          err = err.copyWith(error: const NetworkException("Bad Request"));
          break;
        case 401:
          err = err.copyWith(error: const UnauthorizedException());
          break;
        case 403:
          err = err.copyWith(error: const ForbiddenException());
          break;
        case 404:
          err = err.copyWith(error: const NotFoundException());
          break;
        case 405:
          err =
              err.copyWith(error: const NetworkException("Method Not Allowed"));
          break;
        case 408:
          err = err.copyWith(error: const TimeoutException());
          break;
        case 409:
          err = err.copyWith(error: const NetworkException("Conflict"));
          break;
        case 410:
          err = err.copyWith(error: const NetworkException("Gone"));
          break;
        case 415:
          err = err.copyWith(
              error: const NetworkException("Unsupported Media Type"));
          break;
        case 429:
          err =
              err.copyWith(error: const NetworkException("Too Many Requests"));
          break;

        // 5xx: Server Errors
        case 500:
          err = err.copyWith(
              error: const ServerErrorException("Internal Server Error"));
          break;
        case 501:
          err = err.copyWith(
              error: const ServerErrorException("Not Implemented"));
          break;
        case 502:
          err = err.copyWith(error: const ServerErrorException("Bad Gateway"));
          break;
        case 503:
          err = err.copyWith(
              error: const ServerErrorException("Service Unavailable"));
          break;
        case 504:
          err = err.copyWith(error: const TimeoutException());
          break;
        case 505:
          err = err.copyWith(
              error: const ServerErrorException("HTTP Version Not Supported"));
          break;

        // Fallback for any status code
        default:
          if (statusCode >= 500) {
            err = err.copyWith(
                error: ServerErrorException("Server error ($statusCode)"));
          } else {
            err = err.copyWith(
                error: NetworkException("HTTP Error: $statusCode"));
          }
          break;
      }
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      err = err.copyWith(error: const TimeoutException());
    } else if (err.type == DioExceptionType.cancel) {
      err = err.copyWith(error: const CancelledException());
    } else {
      err = err.copyWith(error: const UnknownNetworkException());
    }

    handler.next(err);
  }
}
