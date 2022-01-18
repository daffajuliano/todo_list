import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login_form_entity.dart';
import '../repositories/auth_repository.dart';

class AuthDoLogin implements UseCase<String, LoginFormEntity> {
  final AuthRepository authRepository;

  AuthDoLogin({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(LoginFormEntity params) async {
    Either<Failure, String> res = await authRepository.login(params);

    return res.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
