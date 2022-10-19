
import 'package:abctechapp/logged_user.dart';
import 'package:abctechapp/model/login.dart';
import 'package:abctechapp/model/user.dart';
import 'package:abctechapp/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginService extends GetxService {
  late final LoginProvider provider;

  LoginService({ required this.provider });

  Future<User> signIn(Login body) async {
    Response response = await provider.signin(body);
    if (response.hasError) {
      return Future.error(ErrorDescription('Erro na conexão'));
    }

    try {
      User result = User.fromMap(response.body);
      LoggedUser.setUser(result);
      LoggedUser.setToken(result.token);
      return Future.sync(() => result);
    } catch (e) {
      e.printError();
      return Future.error(e.toString());
    }
  }
}
