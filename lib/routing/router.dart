import 'package:flutter/material.dart';
import 'package:ohgiri_sample/app/home/home_page.dart';
import 'package:ohgiri_sample/app/home/odai/odai_page.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/app/home/user/sign_in/sign_in_page.dart';

class Routes {
  static const homePage = '/';
  static const createOdaiPage = '/create-odai-page';
}

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(),
          settings: settings,
        );
      case Routes.createOdaiPage:
        final Map<String, dynamic> mapArgs = args;
        final Odai odai = mapArgs['odai'];
        return MaterialPageRoute<dynamic>(
          builder: (_) => CreateOdaiPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        // TODO: Throw
        return null;
    }
  }
}