import 'package:bytebank_novo/components/transaction_auth_dialog.dart';
import 'package:bytebank_novo/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(BytebankApp());
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
