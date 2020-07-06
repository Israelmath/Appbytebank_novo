import 'dart:convert';
import 'package:bytebank_novo/http/webclient.dart';
import 'package:bytebank_novo/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient{


  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(url).timeout(Duration(seconds: 5));
    List<Transaction> transactionList = _toTransactionsList(response);
    return transactionList;
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = json.encode(transaction.toJson());

    final Response response = await client.post(
      url, headers: {'content-type': 'application/json', 'password': '1000'},
      body: transactionJson,
    );

    return Transaction.fromJson(json.decode(response.body));
  }

  List<Transaction> _toTransactionsList(Response response) {
    final List<dynamic> decodedJson = json.decode(response.body);
    final List<Transaction> transactionList = List();

    for (Map<String, dynamic> element in decodedJson) {
      transactionList.add(Transaction.fromJson(element));
    }
    return transactionList;
  }
  
}