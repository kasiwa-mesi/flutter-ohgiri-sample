import 'dart:async';

import 'package:meta/meta.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
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

  Stream<Odai> odaiStream({@required String odaiId}) => _service.documentStream(
        path: FirestorePath.odai(odaiId),
        builder: (data, documentId) => Odai.fromMap(data, documentId),
      );

  Stream<List<Odai>> odaiesStream() => _service.collectionStream(
        path: FirestorePath.odais(uid),
        builder: (data, documentId) => Odai.fromMap(data, documentId),
      );
}