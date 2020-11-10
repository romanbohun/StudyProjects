import 'package:great_places/persistence/sqflite_connection.dart';
import 'package:great_places/places/models/place.dart';
import 'package:sqflite/sqflite.dart';

import 'package:great_places/persistence/connection_abstract.dart';
import 'package:great_places/persistence/repository_abstraction.dart';
import 'package:great_places/persistence/table_abstraction.dart';

class BaseRepository<T extends ATable> implements ARepository<T> {
  final AConnection<Future<Database>> _connection;

  BaseRepository(this._connection);

  @override
  Future<int> add(ATable model) async {
    Database connection;
    try {
      connection = await _connection.getConnection();
      return await connection.insert(model.getTableName(), model.mapValues);
    } catch (error) {
      return -1;
    } finally {
      connection.close();
    }
  }

  @override
  Future<int> delete(ATable model) async {
    Database connection;
    try {
      connection = await _connection.getConnection();
      return await connection.delete(
          model.getTableName(),
          where: model.getDeleteWhereClause(),
          whereArgs: model.getDeleteWhereArgs()
      );
    } catch (error) {
      return -1;
    } finally {
      connection.close();
    }
  }

  @override
  Future<T> get(Map<String, dynamic> whereOptions) async {
    Database connection;
    final model = (T as ATable);
    try {

      connection = await _connection.getConnection();
      final mappedDataList = await connection.query(
          model.getTableName(),
          where: model.getWhereClause(whereOptions),
          whereArgs: whereOptions.values
      );
      return model.factory(mappedDataList.first);
    } catch (error) {
      return null;
    } finally {
      connection.close();
    }
  }

  @override
  Future<List<T>> getAll<T>() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> update(T model) {
    // TODO: implement update
  }

}


class Test {

  void text() {
    final repo = BaseRepository<Place>(SQFliteConnection());
  }
}
