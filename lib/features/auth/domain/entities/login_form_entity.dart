import 'package:equatable/equatable.dart';

class LoginFormEntity extends Equatable {
  final String username;
  final String password;

  const LoginFormEntity({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}
