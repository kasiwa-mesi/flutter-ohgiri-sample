import 'package:ohgiri_sample/app/home/home_page.dart';
import 'package:ohgiri_sample/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData)  {
        return HomePage();
      }
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}