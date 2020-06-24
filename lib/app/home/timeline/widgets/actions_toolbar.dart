import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ohgiri_sample/services/firebase_auth_service.dart';
import 'package:ohgiri_sample/common_widgets/show_exception_alert_dialog.dart';
import 'package:ohgiri_sample/app/home/timeline/timeline_page.dart';
import 'package:ohgiri_sample/app/home/models/answer.dart';
// import 'package:ohgiri_sample/app/home/models/like/liked_user.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';
import 'package:ohgiri_sample/app/home/timeline/answer/answer_page.dart';
import 'package:ohgiri_sample/app/home/timeline/odai/odai_data.dart';

class ActionsToolbar extends StatefulWidget {
  // const ActionsToolbar({Key key, @required this.odaiName}) : super(key: key);
  // final String odaiName;

  @override
  _ActionsToolbarState createState() => _ActionsToolbarState();
}

class _ActionsToolbarState extends State<ActionsToolbar> {
  var uuid = Uuid();
  String _answerName;
  String id;

  @override
  void initState() {
    super.initState();
  }

  //1.お題のフィールドにアンサーコレクションを作る
  //2.アンサーコレクションにnameフィールド、idをつける。
  //必要な処理
  //1.firestoreからお題のIDを取得
  //2.odai/odaiId/answersとpathを指定
  //3.setanswerという関数を作り、お題の保存を実行する。
  //問題.OdaiIdの配列の中から現在のページのIDを取得することがむずかし
  //pageviewのindexを取得できれば、お題IDも特定することができる。
  //Currentindex = 0を定めてから構築すれば、現在のページのindexが取得できるかも???
  //プラスアイコン押した時にモーダルを出現させる。
  //onpressedの時に行う処理
  //1.お題のidを読み込む
  //2.回答作成用のモーダルを出す。
  //モーダルから回答作成用ページに変更する
  //回答ページを作ることによって、エラーを減らす
  //onPressedでページをanswer_page.dartに飛ばす
  Future<void> _openAnswerModal() async {
    try {
      //おそらく、ファイルの設定が間違っていると思う。
      //変に効率化しようとして、エラーが起きている。
      //getSocialIconをケチらず、クズコードで書き直せば、うまくいくかもしれない？？？
      //うまくいった。
      //あとはtimelineUi.dartからお題のIDを取得する事でお題に対する回答を保存する。
      showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('回答作成'),
            content: Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: '回答を入力してください'),
                keyboardAppearance: Brightness.light,
                initialValue: _answerName,
                validator: (value) =>
                    value.isNotEmpty ? null : 'Name can\'t be empty',
                onSaved: (value) => _answerName = value,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('送信'),
                onPressed: () {
                  //回答を送信する処理
                  //回答を作成が成功したことを知らせるdialogを表示
                  _answerName = null;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('wakasama');
      showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      );
      print(e);
    }
  }

  Future<void> _addAnswer() async {
    // try {
    //   final database = Provider.of<FirestoreDatabase>(context, listen: false);
    //   final answerId = uuid.v1();
    //   final answer = Answer(name: _name, id: answerId);
    // } catch (e) {
    //   showExceptionAlertDialog(
    //     context: context,
    //     title: 'Operation failed',
    //     exception: e,
    //   );
    //   print(e);
    // }
  }

  Future<void> _addFavarite() async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      final odaiModel = Provider.of<OdaiModel>(context, listen: false);
      final database = Provider.of<FirestoreDatabase>(context, listen: false);
      odaiModel.funnyIncrement();
      print(odaiModel.funnyNumber);
      //currentUserのidが必要
      id = await auth.getCurrentUser();
      initializeDateFormatting('ja');
      var format = new DateFormat.yMMMd('ja');
      final String createTime = format.format(new DateTime.now());
      // final user = LikedUser(uid: id, createTime: createTime);
      // await database.addFunniedUser(user, odaiModel.odaiMap['id']);
      //answerコレクションのlikeCountフィールドの値を+1できるようにする。
      // await database.
    } catch (e) {
      showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final odaiModel = Provider.of<OdaiModel>(context, listen: false);
    return Container(
        width: 60.0,
        // color: Colors.red[300],
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                iconSize: 35.0,
                padding: EdgeInsets.only(top: 2.0),
                onPressed: () {
                  // Provider.of<OdaiModel>(context, listen: false).getOdai();
                  // _openAnswerModal();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => CreateAnswerPage()),
                  // );
                  odaiModel.getOdai();
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          CreateAnswerPage(odaiMap: odaiModel.odaiMap),
                    ),
                  );
                  // Navigator.of(context).push(
                  //   MaterialPageRoute<void>(
                  //     builder: (context) => Provider<OdaiModel>.value(
                  //       value: Provider.of<OdaiModel>(context, listen: false),
                  //       child: CreateAnswerPage(),
                  //     ),
                  //   ),
                  // );
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                iconSize: 35.0,
                padding: EdgeInsets.only(top: 2.0),
                onPressed: () {
                  // print('kkasuga');
                  _addFavarite();
                },
              ),

              // アイコンボタン
              // _getSocialAction(
              //     icon: Icons.add,
              //     title: '答える',
              //     firebaseConnect: _openAnswerModal()),
              // _getSocialAction(
              //     icon: Icons.favorite,
              //     title: '面白い!',
              //     firebaseConnect: _addFavarite()),
              Padding(
                padding: EdgeInsets.only(bottom: 100.0),
              ),
            ]));
  }
}

Widget _getSocialAction(
    {String title, IconData icon, Future<void> firebaseConnect}) {
  return Container(
    margin: EdgeInsets.only(top: 15.0),
    width: 60.0,
    height: 60.0,
    // child: Column(children: [
    child: IconButton(
      icon: Icon(icon, size: 35.0, color: Colors.black),
      onPressed: () => firebaseConnect,
    ),
    // Padding(
    //   padding: EdgeInsets.only(top: 4.0),
    //   child: Text(title, style: TextStyle(fontSize: 12.0)),
    // )
  );
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
