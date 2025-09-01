import '../../../../Core/network/result.dart';
import '../../../../core/network/response_data.dart';
import '../../data/models/login_request_body.dart';

abstract class LoginRepository {
  Future<Result<ResponseData>> login(SignInRequest request);
}
