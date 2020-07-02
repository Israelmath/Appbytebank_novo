import 'package:bytebank_novo/screens/contact_form.dart';
import 'package:bytebank_novo/screens/contacts_list.dart';
import 'package:bytebank_novo/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database/app_database.dart';
import 'models/contact.dart';

void main() {
  runApp(BytebankApp());
//  save(Contact(6, 'Fulano', 354));
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange[400],
        accentColor: Colors.purple[200],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.purple[200],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}
