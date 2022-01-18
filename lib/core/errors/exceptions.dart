import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exceptions.freezed.dart';

/// This file is greatly inspired by
/// https://gist.github.com/arya-anggara/f57b7c3f388c08036cd7a58522023c2a
///
/// error.response?.data['message'] you can change 'message' according to your API responses.
///
/// for now this exception only for network error.
@freezed
abstract class AppException with _$AppException {
  const factory AppException.requestCancelled() = RequestCancelled;

  const factory AppException.sendTimeout() = SendTimeout;

  const factory AppException.requestTimeout() = RequestTimeout;

  const factory AppException.noInternetConnection() = NoInternetConnection;

  const factory AppException.formatException() = FormatException;

  const factory AppException.defaultError(String error) = DefaultError;

  const factory AppException.unexpectedError() = UnexpectedError;

  // ignore: prefer_constructors_over_static_methods
  static AppException getDioException(dynamic error) {
    if (error is Exception) {
      try {
        late AppException networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.other:
              networkExceptions = const AppException.noInternetConnection();
              break;
            case DioErrorType.connectTimeout:
              networkExceptions = const AppException.requestTimeout();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const AppException.sendTimeout();
              break;
            case DioErrorType.cancel:
              networkExceptions = const AppException.requestCancelled();
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const AppException.sendTimeout();
              break;
            case DioErrorType.response:
              networkExceptions = AppException.defaultError(error.response!.data['errorMessage']);
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const AppException.noInternetConnection();
        } else {
          networkExceptions = const AppException.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const AppException.formatException();
      } catch (_) {
        return const AppException.unexpectedError();
      }
    } else {
      return const AppException.unexpectedError();
    }
  }

  static String getErrorMessage(AppException networkExceptions) {
    String errorMessage = "";
    networkExceptions.when(
      unexpectedError: () {
        errorMessage = "error.unexpectedError".tr();
      },
      requestCancelled: () {
        errorMessage = "error.requestCancelled".tr();
      },
      requestTimeout: () {
        errorMessage = "error.requestTimeout".tr();
      },
      sendTimeout: () {
        errorMessage = "error.sendTimeout".tr();
      },
      noInternetConnection: () {
        errorMessage = "error.noInternetConnection".tr();
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = "error.formatException".tr();
      },
    );
    return errorMessage;
  }
}
