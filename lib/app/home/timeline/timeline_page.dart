import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';
//themeを読み込んで表示したほうがいい。
//1.文字列を表示
//2.firebaseと接続して、themeを表示させる。
//1はできたから2をやる。アーキテクチャー上HomePage以下だから、firebaseの使用は問題ないはず。
//実装できた。
//odaiのフィールドにanswerコレクションを追加する。
//お題に対する回答を保存できるようにする。

class TimelinePage extends StatelessWidget {
  String posts;
  Odai odai;

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(Strings.timeline),
      //   actions: <Widget>[
      //     IconButton(
      //         icon: Icon(Icons.add, color: Colors.white), onPressed: () {}),
      //   ],
      // ),
      // body: buildContents(),
      body: _buildContents(context),
    );
  }
}

Widget _buildContents(BuildContext context) {
  print('TimelinePage rebuild');
  final database = Provider.of<FirestoreDatabase>(context, listen: false);
  final controller = PageController();
  return StreamBuilder<List<Odai>>(
      stream: database.odaisStream(),
      builder: (context, snapshot) {
        print('StreamBuilder: ${snapshot.connectionState}');
        final List<Odai> odaies = snapshot.data;
//この下からエラーが発生しているけど実装はできている。最終確認の時に改善できたら改善する。
// flutter: The following NoSuchMethodError was thrown building StreamBuilder<List<Odai>>(dirty, state:
// flutter: _StreamBuilderBaseState<List<Odai>, AsyncSnapshot<List<Odai>>>#1bff0):
// flutter: The getter 'length' was called on null.
// flutter: Receiver: null
// flutter: Tried calling: length
// flutter:
// flutter: The relevant error-causing widget was:
// flutter:   StreamBuilder<List<Odai>>
// flutter:   file:///Users/yahatanaoki/work/flutter_app/flutter-ohgiri-sample/lib/app/home/timeline/timeline_page.dart:34:10
        // final odaiCount = odaies.length;
        // final odai = odaies[2];
        int odaiCount;
        if (odaies == null) {
          odaiCount = 0;
        } else {
          odaiCount = odaies.length;
        }
        return PageView(
          controller: controller,
          scrollDirection: Axis.vertical,
          children: _buildFullPages(odaiCount, odaies),
        );
      });
}

List<Container> _buildFullPages(int count, List<Odai> odaies) {
  // for (var odai in odaies) {
  //   print(odai.name);
  // }
  List <Container> pages = List.generate(
    count,
    (int index) => Container(
      child: Center(
        child: Text(
          odaies[index].name,
          // 'こんな鮨屋は嫌だ？一体何？',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Colors.black87,
          ),
        ),
      ),
    ),
  );
  return pages;
}
// List<Container> _buildPage() {
//   Container(
//     child: Center(
//       child: Text(
//         odai.name,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 40,
//           color: Colors.black87,
//         ),
//       ),
//     ),
//   );
// }
// final controller = PageController();
// return PageView(
//   controller: controller,
//   scrollDirection: Axis.vertical,
//   children: _buildPage(),
// );

// Widget buildContents() {
//   final controller = PageController();
//   return Container(
//     child: PageView(
//       controller: controller,
//       scrollDirection: Axis.vertical,
//       children: _buildFullPages(10),
//     ),
//   );
// }

// List<Container> _buildFullPages(int count) {
//   List <Container> pages = List.generate(
//     count,
//     (int index) => Container(
//       child: Center(
//         child: Text(
//           //odai.text
//           'こんな鮨屋は嫌だ？一体何？',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 40,
//             color: Colors.black87,
//           ),
//         ),
//       ),
//     ),
//   ),
// //   // Widget build(BuildContext context) {
//   //   return Center(
//   //     child: Text(
//   //       '1',
//   //       style: TextStyle(
//   //         fontWeight: FontWeight.bold,
//   //         fontSize: 100,
//   //         color: Colors.indigo,
//   //       ),
//   //     ),
//   //   );
//   // }
//   return pages;
// }
