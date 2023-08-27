import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manoel_varela/entities/books_entity.dart';
import 'package:manoel_varela/entities/user_entity.dart';
import 'package:manoel_varela/services/user_services.dart';

class UserController {
  final UserService userService = Get.find();
  ValueNotifier<UserEntity> user =
      ValueNotifier(UserEntity(name: '', books: [], uuid: ''));

  void getUserInfo() {
    userService.getUserInfo().then((value) => user.value = value!);
  }

  void setUserName(String name) {
    user.value =
        UserEntity(name: name, books: user.value.books, uuid: user.value.uuid);
  }

  void setUuid(String value) {
    user.value =
        UserEntity(name: user.value.name, books: user.value.books, uuid: value);
  }

  void setUserBooks(List<BookEntity> books) {
    user.value =
        UserEntity(name: user.value.name, books: books, uuid: user.value.uuid);
  }
}
