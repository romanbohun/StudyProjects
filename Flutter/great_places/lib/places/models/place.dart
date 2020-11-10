import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../persistence/table_abstraction.dart';
import '../models/location.dart';

class Place extends ATable {

  final String id;
  final String title;
  final String locationId;
  final String imagePath;

  Location location;
  File image;

  Place({
  @required this.id,
  @required this.title,
  @required this.locationId,
  @required this.imagePath,
    this.location,
    this.image
  });

  /*---- ATable -----*/

  Place factory(Map<String, dynamic> values) {
    return Place(
      id: values['id'],
      title: values['title'],
      locationId: values['locationId'],
      imagePath: values['imagePath']
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
  Map<String, dynamic> get mapValues => {
    'id': this.id,
    'title': this.title,
    'locationId': this.locationId,
    'image': this.imagePath
  };

}