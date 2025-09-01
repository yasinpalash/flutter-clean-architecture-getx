import '../../../../Core/network/result.dart';
import '../../../../core/network/response_data.dart';
import '../../../authentication/domain/repositories/login_repository.dart';
import '../data_sources/login_remote_data_sources.dart';
import '../models/login_request_body.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource _authRepository;

  LoginRepositoryImpl(this._authRepository);

  @override
  Future<Result<ResponseData>> login(SignInRequest request) {
    return _authRepository.signIn(request);
  }
}
