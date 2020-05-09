import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class User {
  // const User({@required this.uid, @required this.displayName, @required this.email});
  const User({@required this.uid, @required this.displayName});
  final String uid;
  final String displayName;
  // final String email;

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }
    return User(uid: documentId, displayName: name);
  }

    Map<String, dynamic> toMap() {
      return {
        'id' : uid,
        'name': displayName,
      };
  }
}

class FirebaseAuthService {
  String userid;
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    // return user == null ? null : User(uid: user.uid, displayName: user.displayName, email: user.email);
    return user == null ? null : User(uid: user.uid, displayName: user.displayName);
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future getCurrentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    userid = user.uid;
    return userid;
  }
}