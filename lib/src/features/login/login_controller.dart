import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manoel_varela/constant/colors.dart';
import 'package:manoel_varela/services/user_services.dart';

class LoginController extends GetxController {
  UserService userService = Get.find();
  String email = '';
  String password = '';

  setEmail(String val) => email = val;
  setPassword(String val) => password = val;
  Future<void> doLogin({required void Function() onSuccess}) async {
    final response = await userService.authenticate(email, password);
    if (response) {
      onSuccess();
    } else {
      Get.snackbar('Usuário ou senha inválidos', 'Tente novamente',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
