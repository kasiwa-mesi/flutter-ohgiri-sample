import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:ohgiri_sample/constants/strings.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';
import 'package:ohgiri_sample/services/firebase_auth_service.dart';

class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  var uuid = Uuid();
  String _name;

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signInAnonymously();
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

  Future<void> _submit(BuildContext context) async {
    if(_validateAndSaveForm()) {
      try {
        final database = Provider.of<FirestoreDatabase>(context, listen: false);
        final id = uuid.v1();
        final user = User(uid: id, displayName: _name);
        await database.setuser(user);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(context),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChilden(context),
      ),
    );
  }

  List<Widget> _buildFormChilden(BuildContext context) {
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
          _signInAnonymously(context);
          _submit(context);
        },
      ),
    ];
  }
}