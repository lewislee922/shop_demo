part of 'login_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogInEvent extends AuthEvent {
  final String username;
  final String password;

  const LogInEvent(this.username, this.password);
}

class LogOutEvnet extends AuthEvent {}
