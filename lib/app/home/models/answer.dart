import 'dart:ui';

import 'package:meta/meta.dart';

class Answer {
  Answer({@required this.id, @required this.odai, @required this.answer, @required this.odaiId, this.likeCount});
  final String id;
  final String odai;
  final String answer;
  final String odaiId;
  int likeCount;

  factory Answer.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String odai = data['odai'];
    final String answer = data['answer'];
    final String odaiId = data['odaiId'];
    if (odai == null) {
      return null;
    }
    if (answer == null) {
      return null;
    }
    return Answer(id: documentId, odai: odai, answer: answer, odaiId: odaiId);
  }

    Map<String, dynamic> toMap() {
      return {
        'odai': odai,
        'answer': answer,
        'odaiId': odaiId,
      };
    }

  @override
  String toString() => 'id: $id, odai: $odai, answer: $answer, odaiId: $odaiId';
}
