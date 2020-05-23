import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:ohgiri_sample/common_widgets/show_exception_alert_dialog.dart';
import 'package:ohgiri_sample/app/home/models/answer.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';
import 'package:ohgiri_sample/app/home/timeline/odai/odai_data.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/app/home/timeline/timeline_page.dart';

//1.answerモデルをを作成
//2.answerpageのUIを作成
class CreateAnswerPage extends StatefulWidget {
  CreateAnswerPage({Key key, @required this.odai}) : super(key: key);
  final Odai odai;

  @override
  _CreateAnswerPageState createState() => _CreateAnswerPageState();
}

class _CreateAnswerPageState extends State<CreateAnswerPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;

  var uuid = Uuid();

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      // print(_validateAndSaveForm());
      //ここはtrueになっているから問題があるのはtryの中
      try {
        final database = Provider.of<FirestoreDatabase>(context, listen: false);
        //上のコードが実行できないので一回ストップ。
        //おそらく、アーキテクチャーを気にせず、一回シンプルなfirebaseアプリを作ったほうがいい
        final id = uuid.v1();
        final odai = Odai(name: widget.odai.name, id: widget.odai.id);
        final answer = Answer(name: _name, id: id);
        await database.setanswer(odai, answer);
        //answer用のfirebaseの設定をする必要がある。
        //お題のIDが必要だから、timelineから渡す必要がある。
        showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text('回答の作成に成功しました!'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('戻る'),
                  onPressed: () {
                    print(_name);
                    _name = null;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        );
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    // final odaiModel = Provider.of<OdaiModel>(context);
    return [
      Center(child: Text(
        '回答作成',
        style: TextStyle(fontSize: 30.0),
      )),
      // Consumer<OdaiModel>(
      //   builder: (context, value, child) {
      //     return Text(value.odai);
      //   },
        // FutureProvider<OdaiModel>(
        //   create: (context) async {
        //     await odaiModel.getOdai();
        //   },
          Center(
            child: Text(
              widget.odai.name,
              // odaiModel.odai,
              // 'お題:',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
              ),
            ),
          ),
        // ),
      // ),
      TextFormField(
        decoration: InputDecoration(labelText: '回答を入力してください'),
        keyboardAppearance: Brightness.light,
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : '回答がありません',
        onSaved: (value) => _name = value,
      ),
      RaisedButton(
        child: Text('作成'),
        color: Colors.black87,
        textColor: Colors.white,
        onPressed: () {
          _submit();
          // print('送信テスト');
        },
      ),
    ];
  }
}
