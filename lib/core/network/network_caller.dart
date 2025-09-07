import 'dart:io';
import 'package:dio/dio.dart';
import 'package:project_structure_temp/core/errors/exceptions.dart';
import 'package:project_structure_temp/core/network/result.dart';
import 'package:project_structure_temp/core/network/server_exception.dart';
import 'package:project_structure_temp/core/utils/logging/logger.dart';

extension NetworkCaller on Dio {
  /// GET Request
  Future<Result<T>> getRequest<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await get(path, queryParameters: queryParameters);
      if (response.statusCode == 200 && response.data != null) {
        return Result.ok(fromJson(response.data));
      } else {
        return Result.error(
            const HttpException("Invalid response from server"));
      }
    } on DioException catch (e) {
      return Result.error(_extractDioError(e));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  /// POST Request
  Future<Result<T>> postRequest<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    try {
      final response = await post(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      if (response.statusCode == 200 && response.data != null) {
        return Result.ok(fromJson(response.data));
      } else {
        return Result.error(
            const HttpException("Invalid response from server"));
      }
    } on DioException catch (e) {
      return Result.error(_extractDioError(e));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  /// PUT Request
  Future<Result<T>> putRequest<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    try {
      final response = await put(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      if (response.statusCode == 200 && response.data != null) {
        return Result.ok(fromJson(response.data));
      } else {
        return Result.error(
            const HttpException("Invalid response from server"));
      }
    } on DioException catch (e) {
      return Result.error(_extractDioError(e));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  /// PATCH Request
  Future<Result<T>> patchRequest<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    try {
      final response = await patch(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      if (response.statusCode == 200 && response.data != null) {
        return Result.ok(fromJson(response.data));
      } else {
        return Result.error(
            const HttpException("Invalid response from server"));
      }
    } on DioException catch (e) {
      return Result.error(_extractDioError(e));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  /// DELETE Request
  Future<Result<T>> deleteRequest<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    try {
      final response = await delete(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      if (response.statusCode == 200 && response.data != null) {
        return Result.ok(fromJson(response.data));
      } else {
        return Result.error(
            const HttpException("Invalid response from server"));
      }
    } on DioException catch (e) {
      return Result.error(_extractDioError(e));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  /// Download File
  Future<Result<T>> downloadFile<T>(
    String url,
    String savePath, {
    required T Function(String path) parser,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200) {
        return Result.ok(parser(savePath));
      } else {
        return Result.error(
          HttpException("Failed to download file: ${response.statusCode}"),
        );
      }
    } on DioException catch (e) {
      return Result.error(_extractDioError(e));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  /// Upload File (e.g. image/pdf/etc.)
  Future<Result<T>> uploadFile<T>(
    String path, {
    required T Function(dynamic json) fromJson,
    required FormData formData,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 200 && response.data != null) {
        return Result.ok(fromJson(response.data));
      } else {
        return Result.error(const HttpException("Failed to upload file"));
      }
    } on DioException catch (e) {
      return Result.error(_extractDioError(e));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Exception _extractDioError(DioException e) {
    final response = e.response;

    if (response != null && response.data != null) {
      final data = response.data;
      AppLoggerHelper.info('Network Error: ${data.toString()}');
      if (data is Map<String, dynamic>) {
        return ServerException(
          statusCode: response.statusCode ?? 0,
          message: data['message']?.toString() ?? 'Unknown error',
          data: data,
        );
      }
    }

    return const UnknownNetworkException();
  }
}
