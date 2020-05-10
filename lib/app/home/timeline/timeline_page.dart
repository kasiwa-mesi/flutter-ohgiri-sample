import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ohgiri_sample/constants/strings.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';

//themeを読み込んで表示したほうがいい。
//1.文字列を表示
//2.firebaseと接続して、themeを表示させる。
//1はできたから2をやる。アーキテクチャー上HomePage以下だから、firebaseの使用は問題ないはず。

class TimelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.timeline),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: buildContents(),
    );
  }
}

Widget buildContents() {
  final controller = PageController();
  return Container(
    child: PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        MyPage1Widget(),
        MyPage2Widget(),
        MyPage3Widget(),
      ],
    ),
  );
}

class MyPage1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '1',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 100,
          color: Colors.indigo,
        ),
      ),
    );
  }
}

class MyPage2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '2',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 100,
          color: Colors.indigo,
        ),
      ),
    );
  }
}

class MyPage3Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '3',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 100,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
