import 'package:ennea_wallet/db/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {

  late DBConnection _databaseConnection;

  Repository(){
    _databaseConnection = DBConnection();
  }

  static Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _databaseConnection.setDatabase();
    return _database!;
  }

  Future<int> insertData(table, data) async{
    var connection = await database;
    return await connection.insert(table, data);
  }

  readAllData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  deleteAllData(table) async {
    var connection = await database;
    return await connection.delete(table);
  }

}