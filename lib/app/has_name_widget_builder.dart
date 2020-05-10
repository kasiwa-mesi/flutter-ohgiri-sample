// import 'package:flutter/material.dart';
// import 'package:ohgiri_sample/services/firebase_auth_service.dart';
// import 'package:ohgiri_sample/services/firestore_database.dart';
// import 'package:provider/provider.dart';

// class HasNameWidgetBuilder extends StatelessWidget {
//   const HasNameWidgetBuilder(
//       {Key key, @required this.builder, @required this.databaseBuilder})
//       : super(key: key);
//   final Widget Function(BuildContext, AsyncSnapshot<User>) builder;
//   final FirestoreDatabase Function(BuildContext context, String uid)
//       databaseBuilder;

//   @override
//   Widget build(BuildContext context) {
//     print('HasNameWidgetBuilder rebuild');
//     final authService =
//         Provider.of<FirebaseAuthService>(context, listen: false);
//     return StreamBuilder<User>(
//       stream: authService.onAuthStateChanged,
//       builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
//         print('StreamBuilder: ${snapshot.connectionState}');
//         final User user = snapshot.data;
//         if (user != null) {
//           return MultiProvider(
//             providers: [
//               Provider<User>.value(value: user),
//               Provider<FirestoreDatabase>(
//                 create: (context) => databaseBuilder(context, user.uid),
//               ),
//               // NOTE: Any other user-bound providers here can be added here
//             ],
//             child: builder(context, snapshot),
//           );
//         }
//         return builder(context, snapshot);
//       },
//     );
//   }
// }