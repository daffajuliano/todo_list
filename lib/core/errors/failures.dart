import 'package:equatable/equatable.dart';

/// Failures often used with dartz either for Failure result (Left result)
abstract class Failure extends Equatable {
  final String? message;

  const Failure({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class ProcessFailure extends Failure {
  const ProcessFailure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  const UnknownFailure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}
