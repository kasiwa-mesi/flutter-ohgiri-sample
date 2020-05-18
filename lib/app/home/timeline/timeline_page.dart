import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/app/home/timeline/widgets/actions_toolbar.dart';
import 'package:ohgiri_sample/app/home/timeline/widgets/timeline_ui.dart';
import 'package:ohgiri_sample/app/home/timeline/odai/odai_data.dart';
//themeを読み込んで表示したほうがいい。
//1.文字列を表示
//2.firebaseと接続して、themeを表示させる。
//1はできたから2をやる。アーキテクチャー上HomePage以下だから、firebaseの使用は問題ないはず。
//実装できた。
//odaiのフィールドにanswerコレクションを追加する。
//お題に対する回答を保存できるようにする。

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  String posts;
  Odai odai;

  // final OdaiModel _odaiModel = OdaiModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OdaiModel>(
      create: (_) => OdaiModel(),
      child: Scaffold(
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TimelineUi(),
            ActionsToolbar(),
          ],
        ),
      ),
    );
  }
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
