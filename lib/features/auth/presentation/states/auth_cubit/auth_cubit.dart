import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/strings.dart';
import '../../../domain/entities/login_form_entity.dart';
import '../../../domain/usecases/auth_do_login.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthDoLogin authDoLogin;

  AuthCubit({required this.authDoLogin}) : super(const AuthState.initial());

  void login(String username, String password) async {
    emit(const AuthState.loading());
    Either<Failure, String> result = await authDoLogin.call(
      LoginFormEntity(username: username, password: password),
    );

    result.fold(
      (failure) => emit(AuthState.failed(failure.message ?? FAILURE_UNKNOWN)),
      (value) => emit(AuthState.loaded(value)),
    );
  }
}
