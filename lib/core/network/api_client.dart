import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/app_urls.dart';
import 'interceptors/global_error_interceptor.dart';
import 'interceptors/http_error_interceptor.dart';
import 'interceptors/internet_check_interceptor.dart';


class ApiClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 1),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      InternetCheckInterceptor(),
      //TokenInterceptor(),
      GlobalErrorInterceptor(),
      HttpErrorInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
      ),
    ]);

    return dio;
  }
}
