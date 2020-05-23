import 'dart:async';

import 'package:meta/meta.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/app/home/models/answer.dart';
import 'package:ohgiri_sample/services/firebase_auth_service.dart';
import 'package:ohgiri_sample/services/firestore_path.dart';
import 'package:ohgiri_sample/services/firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> setodai(Odai odai) async => await _service.setData(
        path: FirestorePath.odai(odai.id),
        data: odai.toMap(),
      );
  
  Future<void> setanswer(Odai odai, Answer answer) async => await _service.setData(
        path: FirestorePath.answer(odai.id, answer.id),
        data: answer.toMap(),
      );

  // Future<void> getodai() async => await _service.getData(
  //   path: FirestorePath.odais(),
  // );

  Future<void> setuser(User user) async => await _service.setData(
        path: FirestorePath.user(user.uid),
        data: user.toMap(),
      );

  Stream<User> userStream({@required String uid}) => _service.documentStream(
        path: FirestorePath.user(uid),
        builder: (data, documentId) => User.fromMap(data, documentId),
      );

  Stream<Odai> odaiStream({@required String odaiId}) => _service.documentStream(
        path: FirestorePath.odai(odaiId),
        builder: (data, documentId) => Odai.fromMap(data, documentId),
      );

  Stream<List<Odai>> odaisStream() => _service.collectionStream(
        path: FirestorePath.odais(),
        builder: (data, documentId) => Odai.fromMap(data, documentId),
      );

  // Stream<List<Odai>> odaiesStream() => _service.collectionStream(
  //       path: FirestorePath.odais(uid),
  //       builder: (data, documentId) => Odai.fromMap(data, documentId),
  //     );
}
