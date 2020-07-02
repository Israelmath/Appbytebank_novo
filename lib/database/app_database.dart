import 'package:bytebank_novo/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then(
    (dbPath) {
      final String path_db = join(dbPath, 'bytebank.db');
      return openDatabase(path_db, onCreate: (db, version) {
        db.execute('CREATE TABLE contacts ('
            'id INTEGER PRIMARY KEY,'
            'name VARCHAR(100),'
            'account_number INTEGER)');
      }, version: 1);
    },
  );
}

Future<int> save(Contact contact) {
  return createDatabase().then(
    (db) {
      final Map<String, dynamic> contactMap = Map();

      contactMap['id'] = contact.id;
      contactMap['name'] = contact.nome;
      contactMap['account_number'] = contact.numero;

      return db.insert('contacts', contactMap);
    },
  );
}

Future<List<Contact>> findAll() {
  return createDatabase().then(
    (db) {
      return db.query('contacts').then(
        (maps) {
          final List<Contact> list_all_contacts = List();
          for (Map<String, dynamic> map in maps) {
            final Contact contact =
                Contact(map['id'], map['name'], map['account_number']);
            list_all_contacts.add(contact);
          }
          return list_all_contacts;
        },
      );
    },
  );
}
