import 'package:dio/dio.dart';
import 'package:network_caller/Core/models/response_data.dart';
import 'package:network_caller/Core/network/api_client.dart';
import 'package:network_caller/Core/network/network_caller.dart';
import 'package:network_caller/Core/network/result.dart';
import 'package:network_caller/Core/utils/constants/app_urls.dart';
import 'package:network_caller/Features/Authentication/data/models/login_request_body.dart';

class LoginRemoteDataSource {
  final Dio _dio = ApiClient.createDio();

  Future<Result<ResponseData>> signIn(SignInRequest request) {
    return _dio.postRequest<ResponseData>(
      AppUrls.login,
      fromJson: (json) => ResponseData.fromJson(json),
      data: request.toJson(),
    );
  }
}
