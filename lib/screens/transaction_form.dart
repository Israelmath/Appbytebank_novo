import 'dart:async';
import 'dart:io';

import 'package:bytebank_novo/components/progress.dart';
import 'package:bytebank_novo/components/response_dialog.dart';
import 'package:bytebank_novo/components/transaction_auth_dialog.dart';
import 'package:bytebank_novo/http/webclients/transaction_webclient.dart';
import 'package:bytebank_novo/models/contact.dart';
import 'package:bytebank_novo/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueControler = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    print('Transaction form Id: $transactionId');
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: Progress(
                  message: 'Enviando...',
                ),
              ),
              Text(
                widget.contact.nome,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.numero.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueControler,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transferir'),
                    onPressed: () {
                      final double valor =
                          double.tryParse(_valueControler.text);
                      final transactionCreated =
                          Transaction(transactionId, valor, widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                _save(transactionCreated, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });

    final Transaction transaction = await _webClient
        .save(transactionCreated, password)
        .catchError((exception) {
      _throwHttpError(context, exception);
    }, test: (exception) => exception is HttpException).catchError((exception) {
      _showTimeoutError(context);
    }, test: (exception) => exception is TimeoutException).catchError(
            (exception) {
      _showError(context);
    });

    setState(() {
      _sending = false;
    });

    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Transação concluída');
          });
      Navigator.pop(context);
    }
  }

  void _showError(BuildContext context) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog('Uknown error');
        });
  }

  void _showTimeoutError(BuildContext context) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog('Timeout Exception');
        });
  }

  void _throwHttpError(BuildContext context, exception) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(exception.message);
        });
  }
}
