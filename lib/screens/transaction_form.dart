import 'package:bytebank_novo/components/response_dialog.dart';
import 'package:bytebank_novo/components/transaction_auth_dialog.dart';
import 'package:bytebank_novo/http/webclients/transaction_webclient.dart';
import 'package:bytebank_novo/models/contact.dart';
import 'package:bytebank_novo/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueControler = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
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
                          Transaction(valor, widget.contact);
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

  void _save(Transaction transactionCreated, String password, BuildContext context) {
    _webClient
        .save(transactionCreated, password)
        .then((transactionDone) {
      if (transactionDone != null) {
        showDialog(context: context, builder: (contextDialog){
          return SuccessDialog('Transação concluída');
        }).then((value) {Navigator.pop(context);});
      }
    }).catchError((exception){
      showDialog(context: context, builder: (contextDialog){
        return FailureDialog(exception.message);
      });
    },
        test: (exception)=> exception is Exception);
  }
}
