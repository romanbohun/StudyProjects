abstract class ATable {

  String tableName; // If null, class name will be taken
  Map<String, bool> primaryKeys;
  Map<String, Type> fields;

  Map<String, dynamic> mapValues;

  ATable factory({Map<String, dynamic> values = const {}});
}

extension TableName on ATable {

  String getTableName() {
    final result = tableName ?? this.toString();
    if (result == null) {
      throw Exception('Could not define table name');
    }
    return result.toLowerCase();
  }

}

extension DmlHelperMethods on ATable {

  String getWhereClause(Map<String, dynamic> keyValues) {
    var stringBuffer = StringBuffer();
    stringBuffer.writeAll(keyValues.keys, " = ? AND ");
    return stringBuffer.toString().substring(0, stringBuffer.length - 5);
  }

  String getDeleteWhereClause() {
    return getWhereClause(primaryKeys);
  }

  List<dynamic> getDeleteWhereArgs() {
    var values = List<dynamic>();
    final valuesSnapshot = mapValues;

    primaryKeys.keys.forEach((key) {
      values.add(valuesSnapshot[key]);
    });

    return values;
  }

}