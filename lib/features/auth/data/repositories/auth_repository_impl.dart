import 'package:dartz/dartz.dart';
import 'package:todo_list/features/auth/data/datasources/auth_local_datasource.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/entities/login_form_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, String>> login(LoginFormEntity requestData) async {
    try {
      String token = await remoteDatasource.login(requestData);
      // cache token
      await localDatasource.cacheToken(token);

      return Right(token);
    } catch (e) {
      if (e is AppException) {
        return Left(ServerFailure(message: AppException.getErrorMessage(e)));
      } else {
        return const Left(ServerFailure(message: FAILURE_UNKNOWN));
      }
    }
  }
}
