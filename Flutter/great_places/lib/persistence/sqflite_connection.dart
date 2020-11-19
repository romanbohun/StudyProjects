import 'package:flutter/foundation.dart';
import 'package:great_places/persistence/table_abstraction.dart';
import 'package:great_places/places/models/place.dart';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import '../persistence/connection_abstract.dart';

class SQFliteConnection implements AConnection<Future<sql.Database>> {
  final _dbName = 'places.db';
  final _version = 1;

  @override
  Future<sql.Database> getConnection() async {
    final dbPath = await sql.getDatabasesPath();
    final fullPath = path.join(dbPath, _dbName);
    return sql.openDatabase(fullPath, onCreate: _createTables, version: _version);
  }

  void _createTables(sql.Database db, int version) {
    db.createTable(Place().factory());
  }

}

extension Ddl on sql.Database {
  Type typeOf<T>() => T;

  void createTable(Place aTable) {

    final tableName = aTable.tableName ?? aTable.toString();
    if (tableName == null) {
      throw Exception('Table name cannot be null');
    }

    final fields = _getFieldsList(aTable);
    execute('CREATE TABLE $tableName ($fields)');
  }

  String _getFieldsList(ATable model) {
    final tableName = model.getTableName();
    if (model.fields.length == 0) {
      throw Exception('Fields are not defined for $tableName');
    }

    var stringBuffer = StringBuffer();
    model.fields.forEach((key, value) {
      stringBuffer.write(key);
      stringBuffer.write(' ');
      stringBuffer.write(_getSqlType(value));

      if (model.primaryKeys?.keys?.contains(key) ?? false) {
        stringBuffer.write(' ');
        stringBuffer.write(' NOT NULL');
        if (model.primaryKeys[key]) {
          stringBuffer.write(' ');
          stringBuffer.write('AUTOINCREMENT');
        }
      }
      stringBuffer.write(',');
    });

    if (model.primaryKeys != null && model.primaryKeys.length > 0) {
      stringBuffer.write('PRIMARY KEY');
      stringBuffer.write('(');
      stringBuffer.writeAll(model.primaryKeys.keys, ",");
      stringBuffer.write(')');
    }

    return stringBuffer
        .toString()
        .substring(0, stringBuffer.length - (model.primaryKeys != null ? 0 : 1));
  }

  String _getSqlType(Type dartType) {
    switch(dartType) {
      case String:
        return 'TEXT';
        break;
    }

    throw Exception('Undefined type');
  }

}
//
//
// extension Dml on sql.Database {
//
//   void insert<T extends ATable>(T model) {
//     final aModel = T as ATable;
//     if (aModel == null) {
//       return;
//     }
//
//     final tableName = aModel.getTableName();
//     var fieldsBuffer = StringBuffer();
//     var valuesBuffer = StringBuffer();
//
//     aModel.mapValues.forEach((key, value) {
//       fieldsBuffer.write('$key,');
//
//       final wrappedValue = _wrapValueIfNeeded(aModel.fields[key], value);
//       valuesBuffer.write('$wrappedValue,');
//     });
//
//     final fields = fieldsBuffer.toString().substring(0, fieldsBuffer.length - 1);
//     final values = valuesBuffer.toString().substring(0, valuesBuffer.length - 1);
//
//     execute('INSERT INTO $tableName ($fields) VALUES ($values)');
//   }
//
//   String _wrapValueIfNeeded(Type type, dynamic value) {
//     switch(type) {
//       case String:
//         return '"$value"';
//         break;
//     }
//
//     throw Exception('Undefined type');
//   }
//
// }