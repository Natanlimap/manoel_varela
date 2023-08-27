import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:manoel_varela/entities/books_entity.dart';
import 'package:manoel_varela/entities/user_entity.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void addListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.toNamed('/');
      } else {
        Get.toNamed('/home');
      }
    });
  }

  Future<bool> authenticate(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      getUserInfo();
      return true;
    } catch (e) {
      return false;
    }
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
            type: BookType.churrasqueira,
            name: e['nome'],
            uuid: e['uuid']))
        .toList();
  }

  Future<List<BookEntity>> getUserBookInfo() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return [];
    final response = await firestore
        .collection('condominios')
        .doc('1OLcAGWqmUfjInE6C6eG')
        .collection('reservas')
        .where('uuid', isEqualTo: firebaseUser.uid)
        .get();
    return response.docs
        .map((e) => BookEntity(
              dateTime: e['data'].toDate(),
              type: BookType.fromString(e['tipo']),
              name: e['nome'],
              uuid: e['uuid'],
              bookId: e.id,
            ))
        .toList();
  }

  Future<UserEntity?> getUserInfo() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return null;
    final response = await firestore
        .collection('condominios')
        .doc('1OLcAGWqmUfjInE6C6eG')
        .collection('apartamentos')
        .where('uuid', isEqualTo: firebaseUser.uid)
        .get();
    final userData = response.docs.first.data();
    List<BookEntity> bookData = [];
    if (userData['nome'] == 'admin') {
      bookData = await getAllBookInfo();
    } else {
      bookData = await getUserBookInfo();
    }
    return UserEntity(
        name: userData['nome'], books: bookData, uuid: firebaseUser.uid);
  }
}
