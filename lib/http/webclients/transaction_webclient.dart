import 'dart:convert';
import 'package:bytebank_novo/http/webclient.dart';
import 'package:bytebank_novo/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TransactionWebClient{


  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(url);
    List<Transaction> transactionList = _toTransactionsList(response);
    return transactionList;
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = json.encode(transaction.toJson());

    await Future.delayed(Duration(seconds: 3));

    final Response response = await client.post(
      url, headers: {'content-type': 'application/json', 'password': password},
      body: transactionJson,
    );


    if(response.statusCode == 200){
      return Transaction.fromJson(json.decode(response.body));
    }
    debugPrint('${response.statusCode}');
    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    400 : 'Error submitting a transaction',
    401 : 'Authentication failed',
    409 : 'transaction already exists'
};

  List<Transaction> _toTransactionsList(Response response) {
    final List<dynamic> decodedJson = json.decode(response.body);
    final List<Transaction> transactionList = List();

    for (Map<String, dynamic> element in decodedJson) {
      transactionList.add(Transaction.fromJson(element));
    }
    return transactionList;
  }
}

class HttpException implements Exception{
  final String message;

  HttpException(this.message);
}