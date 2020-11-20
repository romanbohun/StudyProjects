import '../abstractions/table_abstraction.dart';

abstract class ARepository<T extends ATable> {

  Future<int> add(Map<String, dynamic> values);
  Future<Map<String, dynamic>> get(Map<String, dynamic> whereOptions);
  Future<List<Map<String, dynamic>>> getAll();
  Future<int> update(Map<String, dynamic> values);
  Future<void> delete(List<String> keys, Map<String, dynamic> values);

}
