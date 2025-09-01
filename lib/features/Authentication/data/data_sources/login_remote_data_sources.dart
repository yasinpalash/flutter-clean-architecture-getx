import 'package:dio/dio.dart';
import 'package:project_structure_temp/core/network/network_caller.dart';
import '../../../../Core/network/result.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/response_data.dart';
import '../models/login_request_body.dart';

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
