class FirestorePath {
  static String odai(String odaiId) => '/odai/$odaiId';
  static String answer(String answerId) => '/answer/$answerId';
  static String answers() => 'answer';
  static String odais() => 'odai';
  static String user(String uid) => 'user/$uid';
  static String likedUser(String answerId, String likedUserId) => 'answer/$answerId/likedUser/$likedUserId';
}