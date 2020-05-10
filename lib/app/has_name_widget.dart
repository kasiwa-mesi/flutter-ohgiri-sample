// import 'package:ohgiri_sample/app/home/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:ohgiri_sample/services/firebase_auth_service.dart';

// class HasNameWidget extends StatelessWidget {
//   const HasNameWidget({Key key, @required this.userId, @required this.nickname}) : super(key: key);
//   final String userId;
//   final String nickname;

//   @override
//   Widget build(BuildContext context) {
//     //user.displayNameを持っているかどうかでどのページに移動するか判定する。
//     if (userId != null) {
//       return nickname != null ? HomePage() : SetNamePage();
//     }
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
