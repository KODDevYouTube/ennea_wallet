// ignore_for_file: constant_identifier_names

import 'package:ennea_wallet/db/db_consts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {

  static const _VERSION = 1;
  static const _DB_NAME = 'db_ennea_sqflite';


  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, _DB_NAME);
    var database = await openDatabase(path, version: _VERSION, onCreate: _onCreatingDatabase, onUpgrade: _onUpgrade);
    return database;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('DROP TABLE IF EXISTS $TABLE_WALLET');
      await db.execute('DROP TABLE IF EXISTS $TABLE_TOKEN');

      _onCreatingDatabase(db, newVersion);
    }
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute("CREATE TABLE $TABLE_WALLET "
        "("
        "$WALLET_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$WALLET_MENOMICS TEXT, "
        "$WALLET_NAME TEXT, "
        "$WALLET_ADDRESS TEXT, "
        "$WALLET_PRIVATE_KEY TEXT"
        ")"
    );
    await database.execute("CREATE TABLE $TABLE_TOKEN "
        "("
        "$TOKEN_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$TOKEN_CONTRACT_ADDRESS TEXT, "
        "$TOKEN_ABI TEXT, "
        "$TOKEN_NAME TEXT, "
        "$TOKEN_SYMBOL TEXT, "
        "$TOKEN_DECIMALS INTEGER"
        ")"
    );
  }

}