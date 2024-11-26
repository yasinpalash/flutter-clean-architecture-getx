import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/response_data.dart';

class NetworkCaller {
  final int timeoutDuration = 10;



  // Common headers (e.g., for authentication)
  Map<String, String> _getHeaders() => {
    'Content-Type': 'application/json',
    // Add 'Authorization': 'Bearer <token>' if necessary
  };

  Future<ResponseData> getRequest(String endpoint) async {

    log('GET Request: $endpoint');
    try {
      final Response response = await get(
        Uri.parse(endpoint),
        headers: _getHeaders(),
      )
          .timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> postRequest(String endpoint, {Map<String, dynamic>? body}) async {
    log('POST Request: $endpoint');
    log('Request Body: ${jsonEncode(body)}');

    try {
      final Response response = await
    post(
        Uri.parse(endpoint),
        headers: _getHeaders(),
        body: jsonEncode(body),
      )
          .timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> putRequest(String endpoint, {Map<String, dynamic>? body}) async {

    log('PUT Request: $endpoint');
    log('Request Body: ${jsonEncode(body)}');

    try {
      final Response response = await
          put(
        Uri.parse(endpoint),
        headers: _getHeaders(),
        body: jsonEncode(body),
      )
          .timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> deleteRequest(String endpoint) async {

    log('DELETE Request: $endpoint');
    try {
      final Response response = await delete(
        Uri.parse(endpoint),
        headers: _getHeaders(),
      )
          .timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Handle the response from the server
  ResponseData _handleResponse(http.Response response) {
    log('Response Status: ${response.statusCode}');
    log('Response Body: ${response.body}');

    try {
      final decodedResponse = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
        case 201:
          return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse,
          );
        case 204:
          return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: null,
          );
        case 400:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedResponse['error'] ?? 'There was an issue with your request. Please try again.',
            responseData: null,
          );
        case 401:
          // await AuthController.clearAuthData();
          // AuthController.goToLogin();
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'You are not authorized. Please log in to continue.',
            responseData: null,
          );
        case 403:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'You do not have permission to access this resource.',
            responseData: null,
          );
        case 404:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'The resource you are looking for was not found.',
            responseData: null,
          );
        case 500:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'Internal server error. Please try again later.',
            responseData: null,
          );
        default:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedResponse['error'] ?? 'Something went wrong. Please try again.',
            responseData: null,
          );
      }
    } catch (e) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: 'Failed to process the response. Please try again later.',
        responseData: null,
      );
    }
  }

  // Handle errors during the request process
  ResponseData _handleError(dynamic error) {
    log('Request Error: $error');

    if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        errorMessage: 'Request timed out. Please check your internet connection and try again.',
        responseData: null,
      );
    } else if (error is http.ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        errorMessage: 'Network error occurred. Please check your connection and try again.',
        responseData: null,
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        errorMessage: 'Unexpected error occurred. Please try again later.',
        responseData: null,
      );
    }
  }
}
