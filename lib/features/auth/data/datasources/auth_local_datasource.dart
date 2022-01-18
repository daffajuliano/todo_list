import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/core/utils/strings.dart';

abstract class AuthLocalDatasource {
  Future<void> cacheToken(String token);

  Future<String> getToken();
}

class AuthLocalDatasourceImpl extends AuthLocalDatasource {
  @override
  Future<void> cacheToken(String token) async {
    Box box = await getBox();

    box.put(LOGIN_USER_CACHE, token).onError((error, stackTrace) async {
      log(error.toString());
      throw Exception();
    });
  }

  @override
  Future<String> getToken() async {
    return 'Not Implemented';
  }

  Future<Box> getBox() async {
    return await Hive.openBox(LOGIN_USER_BOX);
  }
}
