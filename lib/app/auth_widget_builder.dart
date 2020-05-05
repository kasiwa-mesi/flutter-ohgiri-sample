import 'package:flutter/material.dart';
import 'package:ohgiri_sample/services/firebase_auth_service.dart';
import 'package:ohgiri_sample/services/firebase_storage_service.dart';
import 'package:ohgiri_sample/services/firestore_service.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {

  const AuthWidgetBuilder({Key key, @required this.builder}) :super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  @override
  Widget build(BuildContext context) {
    print('AuthWidgetBUilder rebuild');
    final authService = Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        print('StreamBuilder: ${snapshot.connectionState}');
        final User user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<User>.value(value: user),
              Provider<FirestoreService>(
                create: (_) => FirestoreService(uid: user.uid),
              ),
              Provider<FirebaseStorageService>(
                create: (_) => FirebaseStorageService(uid: user.uid),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}