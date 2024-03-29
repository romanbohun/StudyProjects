import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../persistence/abstractions/table_abstraction.dart';
import '../models/location.dart';

class Place extends ATable {
  final String id;
  final String title;
  final String locationId;
  final String filePath;

  Location location;

  Place({
    @required this.id,
    @required this.title,
    @required this.locationId,
    @required this.filePath,
    this.location,
  }) : super.factory(null);

  /*---- ATable -----*/

  @override
  Place.factory(Map<String, dynamic> values) :
        id = values['id'],
        title = values['title'],
        locationId = values['locationId'],
        filePath = values['image'], super.factory(values);

  @override
  String get tableName => 'place';

  @override
  Map<String, Type> get fields => {
    'id': String,
    'title': String,
    'locationId': String,
    'image': String
  };

  @override
  Map<String, bool> get primaryKeys => {
    'id' : false
  };

  @override
  Map<String, dynamic> get mapValues => {
    'id': this.id,
    'title': this.title,
    'locationId': this.locationId,
    'image': this.filePath
  };

}