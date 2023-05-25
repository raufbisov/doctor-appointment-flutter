import 'package:doctor_appointment/features/authentication/domain/usecases/refresh_token_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/register_usecase.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:doctor_appointment/features/core/usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/check_auth_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/get_active_user_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/login_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final GetActiveUserUsecase getActiveUserUsecase;
  final CheckAuthUsecase checkAuthUsecase;
  final RefreshTokenUsecase refreshUsecase;
  final RegisterUsecase registerUsecase;
  AuthenticationBloc({
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.getActiveUserUsecase,
    required this.checkAuthUsecase,
    required this.refreshUsecase,
    required this.registerUsecase,
  }) : super(Empty()) {
    on<LoginEvent>((event, emit) async {
      debugPrint('loginevent');

      emit.call(LoggingProcess());
      var result = await loginUsecase(
          LoginParams(email: event.email, password: event.password));
      result.fold((l) => emit.call(AuthError(l.message)),
          (r) => add(GetActiveUserEvent()));
    });
    on<GetActiveUserEvent>((event, emit) async {
      debugPrint('getactiveuserevent');

      var result = await getActiveUserUsecase(NoParams());
      result.fold((l) => emit.call(AuthError(l.message)),
          (r) => emit.call(LoggedIn(r)));
    });
    on<LogoutEvent>((event, emit) async {
      debugPrint('logoutevent');
      emit.call(LoggingProcess());

      var result = await logoutUsecase(NoParams());
      result.fold((l) => emit.call(AuthError(l.message)),
          (r) => emit.call(LoggedOut()));
    });
    on<CheckAuthEvent>((event, emit) async {
      debugPrint('checkauthevent');

      var result = await checkAuthUsecase(NoParams());
      result.fold((l) {
        l is ServerFailure
            ? add(RefreshTokenEvent())
            : emit.call(AuthError(l.message));
      }, (r) {
        r ? add(RefreshTokenEvent()) : emit.call(LoggedOut());
      });
    });
    on<RefreshTokenEvent>((event, emit) async {
      debugPrint('refreshtokenevent');

      var result = await refreshUsecase(NoParams());
      result.fold(
          (l) => add(const LoginEvent(email: '31@gmail.com', password: '31')),
          (r) => add(GetActiveUserEvent()));
    });
    on<RegisterEvent>((event, emit) async {
      debugPrint('registerevent');
      var result = await registerUsecase(RegisterParams(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        phoneNumber: event.phoneNumber,
        age: event.age,
        gender: event.gender,
      ));
      emit.call(LoggingProcess());
      result.fold((l) => emit.call(AuthError(l.message)),
          (r) => add(GetActiveUserEvent()));
    });
  }
}
