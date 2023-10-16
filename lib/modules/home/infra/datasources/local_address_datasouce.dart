import 'package:sqflite/sqflite.dart';

import '../../domain/entities/cep_entity.dart';
import '../adapters/address_adapter.dart';
import '../config/database_config.dart';

abstract class LocalAddressDatasource {
  Future<int> create(AddressEntity object);
  Future<Map<String, dynamic>?> read({
    required String table,
    required String field,
    required String arg,
  });
  Future<int> update(AddressEntity object);
  Future<int> delete(int cep, String tableName);
}

class LocalAddress extends LocalAddressDatasource {
  final Future<Database> _database = DatabaseConfig.instance.database;

  @override
  Future<int> create(AddressEntity object) async {
    var db = await _database;
    var result = await db.insert(
      'Address',
      AddressAdapter.toJson(object),
    );
    return result;
  }

  @override
  Future<Map<String, dynamic>?> read({
    required String table,
    required String field,
    required String arg,
  }) async {
    var db = await _database;
    var results = await db.query(table, where: 'cep = ?', whereArgs: [arg]);
    if (results.isEmpty) {
      return null;
    }
    return results.first;
  }

  @override
  Future<int> update(AddressEntity object) async {
    var db = await _database;
    var result = await db.update(
        object.runtimeType.toString(), AddressAdapter.toJson(object),
        where: 'cep = ?', whereArgs: [object.cep]);
    return result;
  }

  @override
  Future<int> delete(int cep, String tableName) async {
    var db = await _database;
    int result = await db.delete(tableName, where: 'cep = ?', whereArgs: [cep]);
    return result;
  }
}
