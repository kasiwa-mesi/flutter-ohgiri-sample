import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
import 'package:ohgiri_sample/constants/strings.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';
import 'package:ohgiri_sample/services/firebase_auth_service.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String id;
  // var uuid = Uuid();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _signInAnonymously() async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signInAnonymously();
      //ここでAuthのidを取得したい。
      id = await auth.getCurrentUser();
    } catch (e) {
      print(e);
    }
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
    if(_validateAndSaveForm()) { 
      try {
        final database = Provider.of<FirestoreDatabase>(context, listen: false);
        // TextFieldに入力したUserの名前をfirestoreに登録させる
        final user = User(displayName: _name, uid: id);
        await database.setuser(user);
      } catch(e) {
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
    return  SingleChildScrollView(
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
        child: Text("決定"),
        color: Colors.indigo,
        textColor: Colors.white,
        onPressed: () {
          _signInAnonymously();
          _submit();
        },
      ),
    ];
  }
}