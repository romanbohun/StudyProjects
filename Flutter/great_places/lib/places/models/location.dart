import 'package:flutter/foundation.dart';
import 'package:great_places/persistence/abstractions/table_abstraction.dart';

class Location extends ATable {

  final String id;
  final double latitude;
  final double longitude;
  final String address;

  Location({
    @required this.id,
    @required this.latitude,
    @required this.longitude,
    @required this.address
  }) : super.factory(null);

  /*---- ATable -----*/

  @override
  Location.factory(Map<String, dynamic> values) :
      id = values['id'],
      latitude = values['latitude'],
      longitude = values['longitude'],
      address = values['address'], super.factory(values);

  @override
  String get tableName => 'location';

  @override
  Map<String, Type> get fields => {
    'id': String,
    'latitude': double,
    'longitude': double,
    'address': String
  };

  @override
  Map<String, bool> get primaryKeys => {
    'id' : false
  };

  @override
  Map<String, dynamic> get mapValues => {
    'id': this.id,
    'latitude': this.latitude,
    'longitude': this.longitude,
    'address': this.address
  };

}