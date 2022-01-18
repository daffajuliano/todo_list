part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.loaded(String data) = _Loaded;
  const factory AuthState.failed(String message) = _Failed;
}
