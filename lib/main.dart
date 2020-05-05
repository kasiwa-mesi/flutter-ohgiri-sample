import 'package:ohgiri_sample/app/auth_widget.dart';
import 'package:ohgiri_sample/app/auth_widget_builder.dart';
import 'package:ohgiri_sample/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
      ],
      child: AuthWidgetBuilder(builder: (context, userSnapshot) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: AuthWidget(userSnapshot: userSnapshot),
        );
      }),
    );
  }
}