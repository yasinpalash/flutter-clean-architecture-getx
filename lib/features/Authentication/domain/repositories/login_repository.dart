import 'package:network_caller/Core/models/response_data.dart';
import 'package:network_caller/Features/Authentication/data/models/login_request_body.dart';
import 'package:network_caller/Core/network/result.dart';

abstract class LoginRepository {
  Future<Result<ResponseData>> login(SignInRequest request);
}
