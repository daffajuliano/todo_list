import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/login_form_entity.dart';

abstract class AuthRemoteDatasource {
  Future<String> login(LoginFormEntity requestData);
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl(this.dio);

  @override
  Future<String> login(LoginFormEntity requestData) async {
    try {
      print('panggil');
      Response result = await dio.post(
        'login',
        data: json.encode({
          'username': requestData.username,
          'password': requestData.password,
        }),
      );
      print(result.statusCode);

      if (result.statusCode == 200) {
        return result.data['data']['token'];
      } else {
        throw AppException.defaultError(result.data['errorMessage'] ?? result.data['message']);
      }
    } catch (e) {
      print(e.toString());
      throw AppException.getDioException(e);
    }
  }
}
