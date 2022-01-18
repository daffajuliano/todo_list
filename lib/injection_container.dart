import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/utils/strings.dart';
import 'package:todo_list/features/auth/domain/repositories/auth_repository.dart';
import 'package:todo_list/features/auth/domain/usecases/auth_do_login.dart';

import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/states/auth_cubit/auth_cubit.dart';

var sl = GetIt.instance;

Future<void> initLocator() async {
  // Dio
  sl.registerSingleton(
    Dio(
      BaseOptions(
        baseUrl: BASE_URL,
      ),
    ),
  );

  ///////////////
  /// Bloc / Cubit
  ///////////////
  // Auth
  sl.registerFactory(
    () => AuthCubit(
      authDoLogin: sl(),
    ),
  );

  ///////////////
  /// Usecase
  ///////////////
  // Auth
  sl.registerLazySingleton(() => AuthDoLogin(authRepository: sl()));

  ///////////////
  /// Repository
  ///////////////
  // Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
    ),
  );

  ///////////////
  /// DataSource
  ///////////////
  // Auth
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(),
  );
}
