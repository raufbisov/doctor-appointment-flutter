import 'package:doctor_appointment/features/appointment/data/datasources/appointment_remote_datasource.dart';
import 'package:doctor_appointment/features/appointment/data/repositories/appointment_repository.dart';
import 'package:doctor_appointment/features/appointment/domain/repositories/appointment_repository_interface.dart';
import 'package:doctor_appointment/features/appointment/domain/usecases/create_appointment_usecase.dart';
import 'package:doctor_appointment/features/appointment/domain/usecases/get_all_doctors_usecase.dart';
import 'package:doctor_appointment/features/appointment/domain/usecases/read_all_appointments_usecase.dart';
import 'package:doctor_appointment/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:doctor_appointment/features/authentication/data/datasources/auth_remote_datasource_interface.dart';
import 'package:doctor_appointment/features/authentication/data/repositories/auth_repository.dart';
import 'package:doctor_appointment/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/check_auth_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/get_active_user_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/login_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/refresh_token_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/usecases/register_usecase.dart';
import 'package:doctor_appointment/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:doctor_appointment/features/core/error/error_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

void init() {
  // Features
  sl.registerFactory(() => AuthenticationBloc(
      loginUsecase: sl(),
      logoutUsecase: sl(),
      getActiveUserUsecase: sl(),
      checkAuthUsecase: sl(),
      refreshUsecase: sl(),
      registerUsecase: sl()));

  sl.registerFactory(() => AppointmentBloc(
        createAppointmentUsecase: sl(),
        readAllAppointmentsUsecase: sl(),
        getAllDoctorsUsecase: sl(),
      ));

  // Usecases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GetActiveUserUsecase(sl()));
  sl.registerLazySingleton(() => CheckAuthUsecase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));

  sl.registerLazySingleton(() => CreateAppointmentUsecase(sl()));
  sl.registerLazySingleton(() => ReadAllAppointmentsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllDoctorsUsecase(sl()));

  // Repos
  sl.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(remoteDatasource: sl(), errorHandler: sl()));

  sl.registerLazySingleton<IAppointmentRepository>(
      () => AppointmentRepository(datasource: sl(), errorHandler: sl()));

  // Datasources
  sl.registerLazySingleton<IAuthRemoteDatasource>(
      () => AuthRemoteDatasource(sl()));

  sl.registerLazySingleton<IAppointmentRemoteDatasource>(
      () => AppointmentRemoteDatasource(sl()));

  // Other
  const storage = FlutterSecureStorage();
  sl.registerLazySingleton(() => storage);

  sl.registerLazySingleton(() => ErrorHandler());
}
