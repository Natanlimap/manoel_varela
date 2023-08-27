import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manoel_varela/entities/books_entity.dart';
import 'package:manoel_varela/src/features/booking/booking_controller.dart';

class BookingServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> cancelBooking(String bookId) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;
    await firestore
        .collection('condominios')
        .doc('1OLcAGWqmUfjInE6C6eG')
        .collection('reservas')
        .doc(bookId)
        .delete();
  }

  Future<void> doBook(BookEntity bookEntity) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;
    await firestore
        .collection('condominios')
        .doc('1OLcAGWqmUfjInE6C6eG')
        .collection('reservas')
        .add({
      'uuid': bookEntity.uuid,
      'data': bookEntity.dateTime,
      'tipo': bookEntity.type.name,
      'nome': bookEntity.name
    });
  }

  Future<List<BookEntity>> getAllBookInfo() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return [];
    final response = await firestore
        .collection('condominios')
        .doc('1OLcAGWqmUfjInE6C6eG')
        .collection('reservas')
        .get();
    return response.docs
        .map((e) => BookEntity(
            dateTime: e['data'].toDate(),
            type: BookType.fromString(e['tipo']),
            name: e['nome'],
            uuid: e['uuid']))
        .toList();
  }
}
