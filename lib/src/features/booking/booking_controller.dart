import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manoel_varela/entities/books_entity.dart';
import 'package:manoel_varela/services/book_services.dart';
import 'package:manoel_varela/services/user_controller.dart';

class BookingController {
  BookingServices bookingServices = Get.find();
  ValueNotifier<List<BookEntity>> allBooks = ValueNotifier([]);
  Future<void> getAllBooks() async {
    allBooks.value = await bookingServices.getAllBookInfo();
  }

  Future<void> cancelBooking(String bookId) async {
    final UserController userController = Get.find();
    try {
      await bookingServices.cancelBooking(bookId);
      userController.getUserInfo();
    } catch (e) {
      Get.snackbar('Erro ao cancelar', 'Tente novamente mais tarde');
    }
  }

  Future<void> doBook(BookType bookType, DateTime date) async {
    final UserController userController = Get.find();
    try {
      await bookingServices.doBook(
        BookEntity(
            type: bookType,
            dateTime: date,
            name: userController.user.value.name,
            uuid: userController.user.value.uuid),
      );
      userController.getUserInfo();
    } catch (e) {
      Get.snackbar('Erro ao reservar', 'Tente novamente mais tarde');
    }
  }
}
