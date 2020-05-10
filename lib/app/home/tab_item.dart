import 'package:flutter/material.dart';
import 'package:ohgiri_sample/constants/keys.dart';
import 'package:ohgiri_sample/constants/strings.dart';

enum TabItem { timeline, odai, account, setting }

class TabItemData {
  const TabItemData(
      {@required this.key, @required this.title, @required this.icon});

  final String key;
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.timeline: TabItemData(
      key: Keys.timelineTab,
      title: Strings.timeline,
      icon: Icons.work,
    ),
    TabItem.odai: TabItemData(
      key: Keys.odaiTab,
      title: Strings.odai,
      icon: Icons.view_headline,
    ),
    TabItem.account: TabItemData(
      key: Keys.accountTab,
      title: Strings.account,
      icon: Icons.person,
    ),
    TabItem.setting: TabItemData(
      key: Keys.accountTab,
      title: Strings.account,
      icon: Icons.person,
    ),
  };
}