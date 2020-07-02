//Data Access Object - DAO

import 'package:bytebank_novo/database/app_database.dart';
import 'package:bytebank_novo/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDAO{

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _numero = 'account_number';

  static const String tableSql = 'CREATE TABLE $_tableName ('
                                  '$_id INTEGER,'
                                  '$_name VARCHAR(100),'
                                  '$_numero INTEGER)';


  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }


  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String,dynamic> contactMap = Map();
    
    contactMap[_id] = contact.id;
    contactMap[_name] = contact.nome;
    contactMap[_numero] = contact.numero;

    return contactMap;
  }


  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String,dynamic>> contatos = await db.query(_tableName);

    List<Contact> contacts = _toList(contatos);

    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> contatos) {
    final List<Contact> contacts = List();

    for (Map<String, dynamic> row in contatos){
      final Contact contact = Contact(row[_id], row[_name], row[_numero]);
      contacts.add(contact);
    };

    return contacts;
  }

}