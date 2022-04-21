import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_demo/core/error/failure.dart';
import 'package:shop_demo/features/login/data/datasources/login_remote_datasource.dart';
import 'package:shop_demo/features/login/data/repositories/user_login_repository_impl.dart';
import 'package:shop_demo/features/login/domain/repositories/user_login_repository.dart';

class MockLoginRemoteDataSource extends Mock implements LoginRemoteDataSource {
  @override
  Future<String> userLogin(String? username, String? password) =>
      super.noSuchMethod(Invocation.method(#userLogin, [username, password]),
          returnValue: Future.value(""));

  @override
  Future<bool> userLogout() =>
      super.noSuchMethod(Invocation.method(#userLogout, []),
          returnValue: Future.value(true));
}

main() {
  const username = "aab";
  const password = "goo";
  late MockLoginRemoteDataSource loginRemoteDataSource;
  late UserLoginRepository repository;
  group("user login repository implament test", () {
    setUp(() {
      loginRemoteDataSource = MockLoginRemoteDataSource();
      repository = UserLoginRepositoryImpl(loginRemoteDataSource);
    });
    test("should return authorized failure when login unsuccessful", () async {
      when(repository.login(username, password)).thenAnswer(
          (_) async => loginRemoteDataSource.userLogin(username, password));
      when(loginRemoteDataSource.userLogin(username, password))
          .thenThrow(AuthorizedFailure());

      expectLater(repository.login(username, password),
          throwsA(isA<AuthorizedFailure>()));
    });

    test("should return network failure when login have some network problem",
        () {
      when(repository.login(username, password)).thenAnswer(
          (_) async => loginRemoteDataSource.userLogin(username, password));
      when(loginRemoteDataSource.userLogin(username, password))
          .thenAnswer((_) => throw NetworkFailure());

      expectLater(
          repository.login(username, password), throwsA(isA<NetworkFailure>()));
    });

    test("should return token when login is successful", () async {
      when(repository.login(username, password)).thenAnswer(
          (_) async => loginRemoteDataSource.userLogin(username, password));
      when(loginRemoteDataSource.userLogin(username, password))
          .thenAnswer((_) async => "akooke");
      final result = await repository.login(username, password);

      expectLater(result, "akooke");
    });

    test("should return true when logout is successful", () async {
      when(repository.logout())
          .thenAnswer((_) async => loginRemoteDataSource.userLogout());
      when(loginRemoteDataSource.userLogout()).thenAnswer((_) async => true);
      final result = await repository.logout();

      expectLater(result, true);
    });
  });
}
