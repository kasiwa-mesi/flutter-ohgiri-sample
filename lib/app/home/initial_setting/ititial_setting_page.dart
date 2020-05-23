import 'package:flutter/material.dart';
import 'package:ohgiri_sample/constants/strings.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';
import 'package:ohgiri_sample/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class InitialSettingPage extends StatefulWidget {
  @override
  _InitialSettingPageState createState() => _InitialSettingPageState();
}

class _InitialSettingPageState extends State<InitialSettingPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String id;

  @override
  void initState() {
    super.initState();
  }

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
      try {
        final auth = Provider.of<FirebaseAuthService>(context, listen: false);
        final database = Provider.of<FirestoreDatabase>(context, listen: false);
        // TextFieldに入力したUserの名前をfirestoreに登録させる
        id = await auth.getCurrentUser();
        initializeDateFormatting('ja');
        var format = new DateFormat.yMMMd('ja');
        final String createTime = format.format(new DateTime.now());
        final user = User(displayName: _name, uid: id, createTime: createTime, likePostCount: 0);
        await database.setuser(user);
      } catch (e) {
        print(e);
      }
    }
  }

  // Future<void> _submit() async {
  //   if(_validateAndSaveForm()) {
  //     try {
  //       final id = uuid.v1();
  //       final user = User(uid: id, displayName: _name);
  //       final database = Provider.of<FirestoreDatabase>(context, listen: false);
  //       await database.setuser(user);
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChilden(),
      ),
    );
  }

  List<Widget> _buildFormChilden() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: Strings.nickName),
        keyboardAppearance: Brightness.light,
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : 'ニックネームは必ず入力してください',
        onSaved: (value) => _name = value,
      ),
      RaisedButton(
        child: Text("保存"),
        color: Colors.indigo,
        textColor: Colors.white,
        onPressed: () {
          _submit();
        },
      ),
    ];
  }
}
