import '../../domain/repositories/user_login_repository.dart';
import '../datasources/login_remote_datasource.dart';

class UserLoginRepositoryImpl implements UserLoginRepository {
  final LoginRemoteDataSource dataSource;
  UserLoginRepositoryImpl(this.dataSource);
  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
