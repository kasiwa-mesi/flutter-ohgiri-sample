class FirestorePath {
  static String odai(String odaiId) => '/odai/$odaiId';
  static String answer(String odaiId, String answerId) => '/odai/$odaiId/answers/$answerId';
  static String answers(String odaiId) => 'odai/$odaiId/answers';
  static String odais() => 'odai';
  static String user(String uid) => 'user/$uid';
}