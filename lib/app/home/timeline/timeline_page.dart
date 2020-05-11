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

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(Strings.timeline),
      //   actions: <Widget>[
      //     IconButton(
      //         icon: Icon(Icons.add, color: Colors.white), onPressed: () {}),
      //   ],
      // ),
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
      children: _buildFullPages(10),
    ),
  );
}

List<Container> _buildFullPages(int count) {
  List <Container> pages = List.generate(
    count,
    (int index) => Container(
      child: Center(
        child: Text(
          //odai.text
          'こんな鮨屋は嫌だ？一体何？',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Colors.black87,
          ),
        ),
      ),
    ),
  );
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Text(
  //       '1',
  //       style: TextStyle(
  //         fontWeight: FontWeight.bold,
  //         fontSize: 100,
  //         color: Colors.indigo,
  //       ),
  //     ),
  //   );
  // }
  return pages;
}


