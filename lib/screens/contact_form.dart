import 'package:bytebank_novo/dao/contacts_dao.dart';
import 'package:bytebank_novo/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _controlador_nome = TextEditingController();
  final TextEditingController _controlador_numero = TextEditingController();
  final ContactDAO _dao = ContactDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionando contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _controlador_nome,
                decoration: InputDecoration(
                  labelText: 'Nome do contato',
                ),
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            TextField(
              controller: _controlador_numero,
              decoration: InputDecoration(
                labelText: 'Número',
                hintText: '(11) 9.9999-9999',
              ),
              style: TextStyle(
                fontSize: 24,
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Confirmar'),
                  onPressed: (){
                    final String name = _controlador_nome.text;
                    final int numero = int.tryParse(_controlador_numero.text);
                    if (name != null && numero != null){
                      final Contact newContact = Contact(11, name, numero);
                      _dao.save(newContact).then((id) => Navigator.pop(context));
                    };
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
