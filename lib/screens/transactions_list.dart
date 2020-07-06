import 'package:bytebank_novo/http/webclients/transaction_webclient.dart';
import 'package:bytebank_novo/models/centered_message.dart';
import 'package:bytebank_novo/models/progress.dart';
import 'package:bytebank_novo/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactionList = List();
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              /*Para quando o programa não está sequer buscando alguma
            * informação. Daí, o ideal seria termos um botão para reiniciar
            * o future que, neste caso, é o findAll()*/
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              /*Caso o future funcione tal qual streaming. Entrega
            * parte da informação buscada, mas continua buscando
            * e entregando por partes até encontrar e devolver toda
            * a informação.*/
              break;
            case ConnectionState.done:
              if (!snapshot.hasError) {
                final transactionList = snapshot.data;
                if (transactionList.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactionList[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.numero.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                    itemCount: transactionList.length,
                  );
                }
                else{
                  return CenteredMessage('Nenhum contato encontrado', icon: Icons.contacts,);
                }
              }
              break;
          }
          return CenteredMessage(
            'Unknown error',
            icon: Icons.warning,
          );
        },
      ),
    );
  }
}
