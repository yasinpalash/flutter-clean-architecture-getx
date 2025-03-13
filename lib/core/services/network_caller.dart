import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../models/response_data.dart';
import '../utils/logging/logger.dart';
import 'Auth_service.dart';

class NetworkCaller {
  final int timeoutDuration = 10;
  final Dio _dio = Dio();

  NetworkCaller() {
    _dio.options.connectTimeout = Duration(seconds: timeoutDuration);
    _dio.options.receiveTimeout = Duration(seconds: timeoutDuration);
    _dio.options.contentType = 'application/json';
  }

  Future<ResponseData> getRequest(
      String endpoint, {
        String? token,
        Map<String, dynamic>? queryParameters,
      }) async {
    AppLoggerHelper.info('GET Request: $endpoint');
    try {
      final Response response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': token ?? AuthService.token.toString(),
            'Content-Type': 'application/json',
          },
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> postRequest(
      String endpoint, {
        Map<String, dynamic>? body,
        String? token,
        Map<String, dynamic>? queryParameters,
      }) async {
    AppLoggerHelper.info('POST Request: $endpoint');
    AppLoggerHelper.info('Request Body: ${jsonEncode(body)}');
    try {
      final Response response = await _dio.post(
        endpoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': token ?? AuthService.token.toString(),
            'Content-Type': 'application/json',
          },
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> putRequest(
      String endpoint, {
        Map<String, dynamic>? body,
        String? token,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      AppLoggerHelper.info('PUT Request: $endpoint');
      AppLoggerHelper.info('Request Body: ${jsonEncode(body)}');
      final Response response = await _dio.put(
        endpoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': token ??  AuthService.token.toString(),
            'Content-Type': 'application/json',
          },
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> deleteRequest(
      String endpoint,
      String? token, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
      }) async {
    try {
      AppLoggerHelper.info('DELETE Request: $endpoint');
      final Response response = await _dio.delete(
        endpoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': token ?? AuthService.token.toString(),
            'Content-Type': 'application/json',
          },
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return _handleError(e);
    }
  }


  // Handle the response from the server
  Future<ResponseData> _handleResponse(Response response) async {
    AppLoggerHelper.info('Response Status: ${response.statusCode}');
    AppLoggerHelper.info('Response Body: ${response.data.toString()}');
    try {
      final dynamic responseData = response.data;
      switch (response.statusCode) {
        case 200:
        case 201:
          return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode ?? 200,
            responseData: responseData,
            errorMessage: '',
          );
        case 204:
          return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode ?? 204,
            responseData: null,
            errorMessage: '',
          );
        case 400:
          String errorMsg =
              'There was an issue with your request. Please check your information and try again.';
          if (responseData != null && responseData is Map<String, dynamic>) {
            errorMsg = responseData['error'] ?? errorMsg;
            // Try to extract validation errors if available
            if (responseData.containsKey('errors') &&
                responseData['errors'] is Map) {
              final errors = responseData[' '] as Map;
              if (errors.isNotEmpty) {
                final firstError = errors.entries.first;
                errorMsg = firstError.value is List
                    ? firstError.value.first.toString()
                    : firstError.value.toString();
              }
            }
          }
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode ?? 400,
            errorMessage: errorMsg,
            responseData: null,
          );
        case 401:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode ?? 401,
            errorMessage:
            'Your session has expired. Please log in again to continue.',
            responseData: null,
          );
        case 403:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode ?? 403,
            errorMessage: 'You don\'t have permission to access this feature.',
            responseData: null,
          );
        case 404:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode ?? 404,
            errorMessage:
            'The information you\'re looking for couldn\'t be found.',
            responseData: null,
          );
        case 422:
          String errorMsg =
              'The information you provided is invalid. Please check and try again.';
          if (responseData != null && responseData is Map<String, dynamic>) {
            if (responseData.containsKey('errors') &&
                responseData['errors'] is Map) {
              final errors = responseData['errors'] as Map;
              if (errors.isNotEmpty) {
                final firstError = errors.entries.first;
                errorMsg = firstError.value is List
                    ? firstError.value.first.toString()
                    : firstError.value.toString();
              }
            } else if (responseData.containsKey('message')) {
              errorMsg = responseData['message'];
            }
          }
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode ?? 422,
            errorMessage: errorMsg,
            responseData: null,
          );
        case 429:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode ?? 429,
            errorMessage:
            'You\'ve made too many requests. Please try again in a moment.',
            responseData: null,
          );
        case 500:
        case 501:
        case 502:
        case 503:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode ?? 500,
            errorMessage:
            'We\'re experiencing technical difficulties. Please try again later.',
            responseData: null,
          );
        default:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode ?? 0,
            errorMessage: responseData != null &&
                responseData is Map<String, dynamic> &&
                responseData['error'] != null
                ? responseData['error']
                : 'Something went wrong. Please try again.',
            responseData: null,
          );
      }
    } catch (e) {
      log('Response processing error: $e');
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode ?? 0,
        errorMessage:
        'We couldn\'t process the response. Please try again later.',
        responseData: null,
      );
    }
  }

  // Handle Dio-specific errors with user-friendly messages
  ResponseData _handleDioError(DioException error) {
    log('Dio Error: ${error.message}');

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ResponseData(
          isSuccess: false,
          statusCode: 408,
          errorMessage:
          'The connection timed out. Please check your internet and try again.',
          responseData: null,
        );
      case DioExceptionType.sendTimeout:
        return ResponseData(
          isSuccess: false,
          statusCode: 408,
          errorMessage:
          'Sending data timed out. Please try again when you have a better connection.',
          responseData: null,
        );
      case DioExceptionType.receiveTimeout:
        return ResponseData(
          isSuccess: false,
          statusCode: 408,
          errorMessage:
          'The server took too long to respond. Please try again later.',
          responseData: null,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        final responseData = error.response?.data;

        // Try to extract a user-friendly message from the response
        if (responseData != null) {
          if (responseData is Map<String, dynamic>) {
            // Check for common error message fields
            final possibleMessageFields = [
              'message',
              'error',
              'errorMessage',
              'description'
            ];
            for (final field in possibleMessageFields) {
              if (responseData.containsKey(field) &&
                  responseData[field] != null) {
                return ResponseData(
                  isSuccess: false,
                  statusCode: statusCode,
                  errorMessage: responseData[field].toString(),
                  responseData: null,
                );
              }
            }

            // Check for validation errors
            if (responseData.containsKey('errors') &&
                responseData['errors'] is Map) {
              final errors = responseData['errors'] as Map;
              if (errors.isNotEmpty) {
                final firstError = errors.entries.first;
                final errorMsg = firstError.value is List
                    ? firstError.value.first.toString()
                    : firstError.value.toString();
                return ResponseData(
                  isSuccess: false,
                  statusCode: statusCode,
                  errorMessage: errorMsg,
                  responseData: null,
                );
              }
            }
          } else if (responseData is String && responseData.isNotEmpty) {
            return ResponseData(
              isSuccess: false,
              statusCode: statusCode,
              errorMessage: responseData,
              responseData: null,
            );
          }
        }

        // Default messages based on status code
        switch (statusCode) {
          case 400:
            return ResponseData(
              isSuccess: false,
              statusCode: statusCode,
              errorMessage:
              'There was an issue with your request. Please check your information and try again.',
              responseData: null,
            );
          case 401:
            return ResponseData(
              isSuccess: false,
              statusCode: statusCode,
              errorMessage:
              'Your session has expired. Please log in again to continue.',
              responseData: null,
            );
          case 403:
            return ResponseData(
              isSuccess: false,
              statusCode: statusCode,
              errorMessage:
              'You don\'t have permission to access this feature.',
              responseData: null,
            );
          case 404:
            return ResponseData(
              isSuccess: false,
              statusCode: statusCode,
              errorMessage:
              'The information you\'re looking for couldn\'t be found.',
              responseData: null,
            );
          case 422:
            return ResponseData(
              isSuccess: false,
              statusCode: statusCode,
              errorMessage:
              'The information you provided is invalid. Please check and try again.',
              responseData: null,
            );
          case 429:
            return ResponseData(
              isSuccess: false,
              statusCode: statusCode,
              errorMessage:
              'You\'ve made too many requests. Please try again in a moment.',
              responseData: null,
            );
          case 500:
          case 501:
          case 502:
          case 503:
            return ResponseData(
              isSuccess: false,
              statusCode: statusCode,
              errorMessage:
              'We\'re experiencing technical difficulties. Please try again later.',
              responseData: null,
            );
          default:
            return ResponseData(
              isSuccess: false,
              statusCode: statusCode,
              errorMessage: 'Something unexpected happened. Please try again.',
              responseData: null,
            );
        }
      case DioExceptionType.cancel:
        return ResponseData(
          isSuccess: false,
          statusCode: 499,
          errorMessage: 'The request was cancelled.',
          responseData: null,
        );
      case DioExceptionType.connectionError:
        return ResponseData(
          isSuccess: false,
          statusCode: 503,
          errorMessage:
          'No internet connection. Please check your network and try again.',
          responseData: null,
        );
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          return ResponseData(
            isSuccess: false,
            statusCode: 503,
            errorMessage:
            'No internet connection. Please check your network and try again.',
            responseData: null,
          );
        }
        return ResponseData(
          isSuccess: false,
          statusCode: 500,
          errorMessage: 'Something went wrong. Please try again later.',
          responseData: null,
        );
      default:
        return ResponseData(
          isSuccess: false,
          statusCode: 500,
          errorMessage: 'Something went wrong. Please try again later.',
          responseData: null,
        );
    }
  }

  // Handle general errors with user-friendly messages
  ResponseData _handleError(dynamic error) {
    log('General Error: $error');

    String userFriendlyMessage =
        'Something went wrong. Please try again later.';

    if (error is TimeoutException) {
      userFriendlyMessage =
      'The operation timed out. Please try again when you have a better connection.';
    } else if (error.toString().contains('SocketException')) {
      userFriendlyMessage =
      'No internet connection. Please check your network and try again.';
    } else if (error.toString().contains('FormatException')) {
      userFriendlyMessage =
      'We received an unexpected response. Please try again later.';
    }


    return ResponseData(
      isSuccess: false,
      statusCode: 500,
      errorMessage: userFriendlyMessage,
      responseData: null,
    );
  }
}
