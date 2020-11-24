import 'package:flutter/foundation.dart';

import 'package:great_places/persistence/repositories/location_repository.dart';
import 'package:great_places/places/models/location.dart';

class LocationProvider with ChangeNotifier {
  final _repository = LocationRepository();

  Future<Location> add(Location location) async {
    final result = await _repository.add(location.mapValues);
    return result < 0 ? null : location;
  }
}