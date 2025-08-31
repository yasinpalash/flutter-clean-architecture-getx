import 'package:network_caller/Core/models/response_data.dart';
import 'package:network_caller/Features/Authentication/data/data_sources/login_remote_data_sources.dart';
import 'package:network_caller/Features/Authentication/data/models/login_request_body.dart';
import 'package:network_caller/Features/Authentication/domain/repositories/login_repository.dart';
import 'package:network_caller/Core/network/result.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource _authRepository;

  LoginRepositoryImpl(this._authRepository);

  @override
  Future<Result<ResponseData>> login(SignInRequest request) {
    return _authRepository.signIn(request);
  }
}
