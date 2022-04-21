abstract class UserLoginRepository {
  Future<String> login(String username, String password);
  Future<bool> logout();
}
