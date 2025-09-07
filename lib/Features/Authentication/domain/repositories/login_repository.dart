import 'package:project_structure_temp/Features/Authentication/data/models/login_request_body.dart';
import 'package:project_structure_temp/core/network/response_data.dart';
import 'package:project_structure_temp/core/network/result.dart';

abstract class LoginRepository {
  Future<Result<ResponseData>> login(SignInRequest request);
}
