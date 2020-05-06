import 'package:flutter/cupertino.dart';
import 'package:ohgiri_sample/app/home/odai/odai_page.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';

class CupertinoTabViewsRoutes {
  static const createOdaiPage = '/create-odai-page';
}

class CupertinoTabViewRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewsRoutes.createOdaiPage:
        return CupertinoPageRoute(
          builder: (_) => CreateOdaiPage(),
          settings: settings,
          fullscreenDialog: true,
        );
    }
    return null;
  }
}