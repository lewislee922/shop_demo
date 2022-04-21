part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String _token;
  String get token => _token;

  const LoginSuccess(this._token);
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
}

class LoginProcessing extends LoginState {}
