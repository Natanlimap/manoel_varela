// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:manoel_varela/entities/books_entity.dart';

class UserEntity {
  String name;
  String uuid;
  List<BookEntity> books;
  UserEntity({
    required this.name,
    required this.books,
    required this.uuid,
  });
}
