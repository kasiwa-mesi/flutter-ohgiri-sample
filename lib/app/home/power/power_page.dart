import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ohgiri_sample/common_widgets/show_exception_alert_dialog.dart';
import 'package:ohgiri_sample/app/home/models/power.dart';
import 'package:ohgiri_sample/constants/strings.dart';
import 'package:ohgiri_sample/services/firestore_database.dart';

class PowerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.odai),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {}
          ),
        ],
      ),
    );
  }
}