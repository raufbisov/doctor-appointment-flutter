part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Empty extends AuthenticationState {}

class LoggedOut extends AuthenticationState {}

class LoggingProcess extends AuthenticationState {}

class LoggedIn extends AuthenticationState {
  final User user;

  const LoggedIn(this.user);
}

class TokenExpired extends AuthenticationState {}

class AuthError extends AuthenticationState {
  final String message;

  const AuthError(this.message);
}
