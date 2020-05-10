// お題がたくさん流れてるTimeLinePage（回答ページ)
import 'package:flutter/material.dart';
import 'package:ohgiri_sample/app/home/user/auth_widget.dart';
import 'package:ohgiri_sample/app/home/cupertino_home_scaffold.dart';
import 'package:ohgiri_sample/app/home/odai/odai_page.dart';
import 'package:ohgiri_sample/app/home/user/account/account_page.dart';
import 'package:ohgiri_sample/app/home/power/power_page.dart';
import 'package:ohgiri_sample/app/home/timeline/timeline_page.dart';
import 'package:ohgiri_sample/app/home/initial_setting/ititial_setting_page.dart';
import 'package:ohgiri_sample/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.timeline;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.timeline: GlobalKey<NavigatorState>(),
    TabItem.odai: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
    TabItem.setting: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.timeline: (_) => TimelinePage(),
      TabItem.odai: (context) => CreateOdaiPage(),
      TabItem.account: (_) => AccountPage(),
      TabItem.setting: (_) => InitialSettingPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }

}