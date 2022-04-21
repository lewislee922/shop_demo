import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_demo/core/error/failure.dart';

import '../../domain/usecases/user_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<AuthEvent, LoginState> {
  final UserLogin login;
  LoginBloc(this.login) : super(LoginInitial()) {
    on<LogInEvent>((event, emit) async {
      emit(LoginProcessing());
      try {
        final _token = await login.login(event.username, event.password);
        emit(LoginSuccess(_token));
      } catch (e) {
        if (e is NetworkFailure) {
          emit(const LoginFailure(
              "Network error, please check your network status"));
        }
        if (e is AuthorizedFailure) {
          emit(const LoginFailure("No username or incorrect password"));
        }
      }
    });
    on<LogOutEvnet>((event, emit) {});
  }
}
