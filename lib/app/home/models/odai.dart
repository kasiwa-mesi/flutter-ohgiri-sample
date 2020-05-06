import 'dart:ui';

import 'package:meta/meta.dart';

class Odai {
  Odai({@required this.id, @required this.name});
  final String id;
  final String name;

  factory Odai.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }
    return Odai(id: documentId, name: name);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  @override
  int get hashCode => hashValues(id, name);

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Odai otherodai = other;
    return id == otherodai.id &&
        name == otherodai.name;
  }

  @override
  String toString() => 'id: $id, name: $name';
}