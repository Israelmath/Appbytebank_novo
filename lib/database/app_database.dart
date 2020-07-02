import 'package:bytebank_novo/dao/contacts_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = await getDatabasesPath();
  final String pathDb = join(path, 'bytebank.db');
  
  return openDatabase(pathDb, onCreate: (db, version) {
        db.execute(ContactDAO.tableSql);
      }, version: 1,
//      onDowngrade: onDatabaseDowngradeDelete
      );
//  return getDatabasesPath().then(
//    (dbPath) {
//      final String path_db = join(dbPath, 'bytebank.db');
//      return openDatabase(path_db, onCreate: (db, version) {
//        db.execute('CREATE TABLE contacts ('
//            'id INTEGER,'
//            'name VARCHAR(100),'
//            'account_number INTEGER)');
//      }, version: 1,
////      onDowngrade: onDatabaseDowngradeDelete
//      );
//    },
//  );
}


