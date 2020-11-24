import 'package:great_places/persistence/sqflite_connection.dart';
import 'package:sqflite/sqflite.dart';

import '../abstractions/connection_abstract.dart';
import '../abstractions/repository_abstraction.dart';
import '../abstractions/table_abstraction.dart';

abstract class BaseRepository<T extends ATable> implements ARepository<T> {
  final AConnection<Future<Database>> storageConnection;
  final String _tableName;

  BaseRepository(this._tableName, {this.storageConnection = const SQFliteConnection()});

  @override
  Future<int> add(Map<String, dynamic> values) async {
    Database connection;
    try {
      connection = await storageConnection.getConnection();
      return await connection.insert(
          _tableName,
          values,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (error) {
      return -1;
    } finally {
      connection.close();
    }
  }

  @override
  Future<int> delete(List<String> keys, Map<String, dynamic> values) async {
    Database connection;
    try {
      connection = await storageConnection.getConnection();
      return await connection.delete(
          _tableName,
          where: _getWhereClause(keys),
          whereArgs: _getWhereArgs(keys, values)
      );
    } catch (error) {
      return -1;
    } finally {
      connection.close();
    }
  }

  @override
  Future<Map<String, dynamic>> get(Map<String, dynamic> whereOptions) async {
    Database connection;
    try {
      connection = await storageConnection.getConnection();
      final data = await connection.query(
          _tableName,
          where: _getWhereClause(whereOptions.keys),
          whereArgs: whereOptions.values
      );
      return data.first;
    } catch (error) {
      return null;
    } finally {
      connection.close();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    Database connection;
    try {
      connection = await storageConnection.getConnection();
      return await connection.query(_tableName);
    } catch (error) {
      return null;
    } finally {
      connection.close();
    }
  }

  @override
  Future<int> update(Map<String, dynamic> values) async {
    Database connection;
    try {
      connection = await storageConnection.getConnection();
      return await connection.update(_tableName, values);
    } catch (error) {
      return null;
    } finally {
      connection.close();
    }
  }

  String _getWhereClause(List<String> keys) {
    var stringBuffer = StringBuffer();
    stringBuffer.writeAll(keys, " = ? AND ");
    return stringBuffer.toString().substring(0, stringBuffer.length - 5);
  }

  List<dynamic> _getWhereArgs(List<String> keys, Map<String, dynamic> values) {
    var result = List<dynamic>();
    final valuesSnapshot = values;

    keys.forEach((key) {
      result.add(valuesSnapshot[key]);
    });

    return result;
  }

}