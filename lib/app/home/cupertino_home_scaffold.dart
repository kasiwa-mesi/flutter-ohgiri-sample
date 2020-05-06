import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohgiri_sample/app/home/tab_item.dart';
import 'package:ohgiri_sample/constants/keys.dart';
import 'package:ohgiri_sample/routing/cupertino_tab_view_route.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.widgetBuilders,
    @required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        key: Key(Keys.tabBar),
        items: [
          _buildItem(TabItem.timeline),
          _buildItem(TabItem.odai),
          _buildItem(TabItem.timeline),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item](context),
          onGenerateRoute: CupertinoTabViewRouter.generateRoute,
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      title: Text(
        itemData.title,
        key: Key(itemData.key),
        style: TextStyle(color: color),
      ),
    );
  }
}