import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_demo/core/error/failure.dart';
import 'package:shop_demo/features/login/domain/usecases/user_login.dart';
import 'package:shop_demo/features/login/presentation/bloc/login_bloc.dart';

class MockUserLogin extends Mock implements UserLogin {
  @override
  Future<String> login(String? username, String? password) =>
      super.noSuchMethod(Invocation.method(#login, [username, password]),
          returnValue: Future.value(""));

  @override
  Future<bool> logout() => super.noSuchMethod(Invocation.method(#logout, []),
      returnValue: Future.value(true));
}

void main() {
  late MockUserLogin userLogin;
  group("Bloc test", () {
    setUp(() {
      userLogin = MockUserLogin();
    });

    test("should get initial state with no event emit", () {
      final bloc = LoginBloc(userLogin);
      expect(bloc.state, LoginInitial());
    });

    blocTest<LoginBloc, LoginState>(
      "should get success state after login",
      build: () {
        when(userLogin.login(any, any)).thenAnswer((_) async => "qoo");
        return LoginBloc(userLogin);
      },
      act: (bloc) => bloc.add(const LogInEvent("acc", "test1")),
      expect: () => [LoginProcessing(), const LoginSuccess("qoo")],
    );

    blocTest<LoginBloc, LoginState>(
      "should get failure state when api reject",
      build: () {
        when(userLogin.login(any, any)).thenThrow(AuthorizedFailure());
        return LoginBloc(userLogin);
      },
      act: (bloc) => bloc.add(const LogInEvent("acc", "test1")),
      expect: () => [
        LoginProcessing(),
        const LoginFailure("No username or incorrect password")
      ],
    );

    blocTest<LoginBloc, LoginState>(
      "should get failure state when network error",
      build: () {
        when(userLogin.login(any, any)).thenThrow(NetworkFailure());
        return LoginBloc(userLogin);
      },
      act: (bloc) => bloc.add(const LogInEvent("acc", "test1")),
      expect: () => [
        LoginProcessing(),
        const LoginFailure("Network error, please check your network status")
      ],
    );
  });
}
