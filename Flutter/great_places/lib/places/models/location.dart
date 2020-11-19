import 'package:flutter/foundation.dart';
import 'package:great_places/persistence/table_abstraction.dart';

class Location extends ATable {

  final int id;
  final double latitude;
  final double longitude;
  final String address;

  Location({
    @required this.id,
    @required this.latitude,
    @required this.longitude,
    @required this.address
  });

  @override
  Location factory({Map<String, dynamic> values = const {}}) {
    return Location(
      id: values['id'],
      latitude: values['latitude'],
      longitude: values['longitude'],
      address: values['address']
    );
  }

}