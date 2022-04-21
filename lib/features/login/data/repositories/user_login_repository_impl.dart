import '../../domain/repositories/user_login_repository.dart';
import '../datasources/login_remote_datasource.dart';

class UserLoginRepositoryImpl implements UserLoginRepository {
  final LoginRemoteDataSource dataSource;
  UserLoginRepositoryImpl(this.dataSource);
  @override
  Future<String> login(String username, String password) async {
    try {
      final _result = await dataSource.userLogin(username, password);
      return _result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> logout() async {
    return await dataSource.userLogout();
  }
}
