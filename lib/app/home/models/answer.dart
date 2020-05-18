import 'dart:ui';

import 'package:meta/meta.dart';

class Answer {
  Answer({@required this.id, @required this.name});
  final String id;
  final String name;

  factory Answer.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }
    return Answer(id: documentId, name: name);
  }

    Map<String, dynamic> toMap() {
      return {
        'name': name,
      };
    }

  @override
  String toString() => 'id: $id, name: $name';
}
