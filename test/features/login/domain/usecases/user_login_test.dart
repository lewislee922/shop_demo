import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_demo/core/error/failure.dart';
import 'package:shop_demo/features/login/domain/repositories/user_login_repository.dart';
import 'package:shop_demo/features/login/domain/usecases/user_login.dart';

class MockUserLoginRepository extends Mock implements UserLoginRepository {
  @override
  Future<String> login(String? username, String? password) =>
      super.noSuchMethod(Invocation.method(#login, [username, password]),
          returnValue: Future.value(""));

  @override
  Future<bool> logout() => super.noSuchMethod(Invocation.method(#logout, []),
      returnValue: Future.value(true));
}

void main() {
  late MockUserLoginRepository repository;
  late UserLogin userLogin;
  const username = "aab";
  const password = "goo";
  group("login usecase test", () {
    setUp(() {
      repository = MockUserLoginRepository();
      userLogin = UserLogin(repository);
    });

    test("should return authorized failure when login unsuccessful", () async {
      when(userLogin.login(username, password))
          .thenAnswer((_) async => repository.login(username, password));
      when(repository.login(username, password)).thenThrow(AuthorizedFailure());

      expectLater(userLogin.login(username, password),
          throwsA(isA<AuthorizedFailure>()));
    });

    test("should return network failure when login have some network problem",
        () {
      when(userLogin.login(username, password))
          .thenAnswer((_) async => repository.login(username, password));
      when(repository.login(username, password))
          .thenAnswer((_) => throw NetworkFailure());

      expectLater(
          userLogin.login(username, password), throwsA(isA<NetworkFailure>()));
    });

    test("should return token when login is successful", () async {
      when(userLogin.login(username, password))
          .thenAnswer((_) async => repository.login(username, password));
      when(repository.login(username, password))
          .thenAnswer((_) async => "akooke");
      final result = await userLogin.login(username, password);

      expectLater(result, "akooke");
    });

    test("should return true when logout is successful", () async {
      when(userLogin.login(username, password))
          .thenAnswer((_) async => repository.login(username, password));
      when(repository.logout()).thenAnswer((_) async => true);
      final result = await userLogin.logout();

      expectLater(result, true);
    });
  });
}
