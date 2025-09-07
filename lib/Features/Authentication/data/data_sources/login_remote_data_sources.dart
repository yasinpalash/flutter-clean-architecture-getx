import 'package:dio/dio.dart';
import 'package:project_structure_temp/Features/Authentication/data/models/login_request_body.dart';
import 'package:project_structure_temp/core/constants/app_urls.dart';
import 'package:project_structure_temp/core/network/api_client.dart';
import 'package:project_structure_temp/core/network/network_caller.dart';
import 'package:project_structure_temp/core/network/response_data.dart';
import 'package:project_structure_temp/core/network/result.dart';

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
