import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:project_structure_temp/core/constants/app_urls.dart';
import 'package:project_structure_temp/core/network/interceptors/global_error_interceptor.dart';
import 'package:project_structure_temp/core/network/interceptors/http_error_interceptor.dart';
import 'package:project_structure_temp/core/network/interceptors/internet_check_interceptor.dart';

class ApiClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
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
      if (!kReleaseMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
    ]);

    return dio;
  }
}
