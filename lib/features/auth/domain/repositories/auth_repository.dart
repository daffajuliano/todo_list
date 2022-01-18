import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/login_form_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(LoginFormEntity requestData);
}
