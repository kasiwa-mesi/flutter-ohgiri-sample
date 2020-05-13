import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:ohgiri_sample/common_widgets/show_exception_alert_dialog.dart';
import 'package:ohgiri_sample/app/home/models/answer.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';

class ActionsToolbar extends StatefulWidget {
  const ActionsToolbar({Key key, @required this.odaiId}) : super(key: key);
  final String odaiId;

  @override
  _ActionsToolbarState createState() => _ActionsToolbarState();
}

class _ActionsToolbarState extends State<ActionsToolbar> {
  var uuid = Uuid();

  //1.お題のフィールドにアンサーコレクションを作る
  //2.アンサーコレクションにnameフィールド、idをつける。
  //必要な処理
  //1.firestoreからお題のIDを取得
  //2.odai/odaiId/answersとpathを指定
  //3.setanswerという関数を作り、お題の保存を実行する。
  //問題.OdaiIdの配列の中から現在のページのIDを取得することがむずかし
  //pageviewのindexを取得できれば、お題IDも特定することができる。
  //Currentindex = 0を定めてから構築すれば、現在のページのindexが取得できるかも???
  Future<void> _addAnswer() async {
    try {
      final database = Provider.of<FirestoreDatabase>(context, listen: false);
      final id = uuid.v1();
    } catch (e) {
      showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      );
      print(e);
    }
  }

  Future<void> _addFavarite() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      // color: Colors.red[300],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // IconButton(
          //   icon: Icon(Icons.add),
          //   onPressed: () {

          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.favorite),
          //   onPressed: () {

          //   },
          // )
          _getSocialAction(
              icon: Icons.add, title: '答える', firebaseConnect: _addAnswer()),
          _getSocialAction(
              icon: Icons.favorite,
              title: '面白い!',
              firebaseConnect: _addFavarite()),
          Padding(
            padding: EdgeInsets.only(bottom: 80.0),
          ),
        ],
      ),
    );
  }
}

Widget _getSocialAction(
    {String title, IconData icon, Future<void> firebaseConnect}) {
  return Container(
      margin: EdgeInsets.only(top: 15.0),
      width: 60.0,
      height: 60.0,
      child: Column(children: [
        IconButton(
          icon: Icon(icon, size: 35.0, color: Colors.black),
          onPressed: () {
            firebaseConnect;
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Text(title, style: TextStyle(fontSize: 12.0)),
        )
      ]));
}

// Widget _getSocialAction({String title, IconData icon}) {
//   return Container(
//       margin: EdgeInsets.only(top: 15.0),
//       width: 60.0,
//       height: 60.0,
//       child: Column(children: [
//         Icon(icon, size: 35.0, color: Colors.black),
//         Padding(
//           padding: EdgeInsets.only(top: 2.0),
//           child: Text(title, style: TextStyle(fontSize: 12.0)),
//         )
//       ]));
// }
