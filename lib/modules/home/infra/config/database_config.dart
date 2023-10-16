import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/address_database_model.dart';

class DatabaseConfig {
  static const String _databaseName = "buscacep_database.db";
  static final DatabaseConfig instance = DatabaseConfig._singleton();
  static Database? _database;

  DatabaseConfig._singleton();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _initDB();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(path, onCreate: _createDB, version: 1);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const stringType = 'TEXT';

    await db.execute('''
      CREATE TABLE ${AddressDatabaseModel.TABLE_NAME} 
      (
          ${AddressDatabaseModel.ID} $idType,
          ${AddressDatabaseModel.CEP} $stringType,
          ${AddressDatabaseModel.LOGRADOURO} $stringType,
          ${AddressDatabaseModel.COMPLEMENTO} $stringType,
          ${AddressDatabaseModel.BAIRRO} $stringType,
          ${AddressDatabaseModel.LOCALIDATE} $stringType,
          ${AddressDatabaseModel.UF} $stringType,
          ${AddressDatabaseModel.IBGE} $stringType,
          ${AddressDatabaseModel.GIA} $stringType,
          ${AddressDatabaseModel.DDD} $stringType,
          ${AddressDatabaseModel.SIAFI} $stringType 
      )
      ''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
