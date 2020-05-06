import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ohgiri_sample/common_widgets/show_exception_alert_dialog.dart';
import 'package:ohgiri_sample/app/home/models/odai.dart';
import 'package:ohgiri_sample/constants/strings.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';


class CreateOdaiPage extends StatefulWidget {
  @override
  _CreateOdaiPageState createState() => _CreateOdaiPageState();
}

class _CreateOdaiPageState extends State<CreateOdaiPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;

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
      // print(_validateAndSaveForm());
      //ここはtrueになっているから問題があるのはtryの中
      try {
        final database = Provider.of<FirestoreDatabase>(context, listen: false);
        final id = documentIdFromCurrentDate();
        final odai = Odai(name: _name, id: id);
        await database.setodai(odai);
        Navigator.of(context).pop();
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
      appBar: AppBar(
        title: Text(Strings.odai),
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
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
        decoration: InputDecoration(labelText: Strings.exapleOdai),
        keyboardAppearance: Brightness.light,
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
      RaisedButton(
        child: Text("送信"),
        color: Colors.indigo,
        textColor: Colors.white,
        onPressed: _submit,
      ),
    ];
  }
}
