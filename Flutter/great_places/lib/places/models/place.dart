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
  File image;

  Place({
  this.id,
  this.title,
  this.locationId,
  this.filePath,
    this.location,
    this.image
  });

  /*---- ATable -----*/

  Place factory({Map<String, dynamic> values = const {}}) {
    return Place(
      id: values['id'],
      title: values['title'],
      locationId: values['locationId'],
      filePath: values['imagePath']
    );
  }

  @override
  String get tableName => 'places';

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