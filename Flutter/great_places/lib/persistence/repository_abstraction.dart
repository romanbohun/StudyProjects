import 'package:flutter/foundation.dart';

import 'package:great_places/persistence/table_abstraction.dart';

abstract class ARepository<T extends ATable> {

  Future<int> add(T model);
  Future<T> get(Map<String, dynamic> keys);
  Future<List<T>> getAll<T>();
  Future<void> update(T model);
  Future<void> delete(T model);

}
