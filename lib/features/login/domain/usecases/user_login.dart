import 'package:shop_demo/features/login/presentation/bloc/login_bloc.dart';

import '../repositories/user_login_repository.dart';

class UserLogin {
  final UserLoginRepository repository;

  UserLogin(this.repository);

  Future<String> login(String username, String password) async {
    try {
      final _result = await repository.login(username, password);
      return _result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> logout() => repository.logout();
}
