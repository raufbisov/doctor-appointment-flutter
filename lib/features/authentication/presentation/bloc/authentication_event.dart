part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthenticationEvent {}

class GetActiveUserEvent extends AuthenticationEvent {}

class CheckAuthEvent extends AuthenticationEvent {}

class RefreshTokenEvent extends AuthenticationEvent {}

class RegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final int age;
  final Gender gender;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.age,
    required this.gender,
  });
}
