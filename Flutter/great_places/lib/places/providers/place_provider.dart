import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:great_places/persistence/repositories/base_repository.dart';
import 'package:great_places/persistence/repositories/location_repository.dart';
import 'package:great_places/persistence/repositories/place_repository.dart';
import 'package:great_places/persistence/sqflite_connection.dart';
import 'package:great_places/places/models/location.dart';

import '../models/place.dart';

class PlaceProvider with ChangeNotifier {
  final _placeRepository = PlaceRepository();
  final _locationRepository = LocationRepository();
  List<Place> _places = [];
  List<Place> get places {
    return [..._places];
  }

  Future<void> add(String title, String pickedFilePath, Location location) async {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      filePath: pickedFilePath,
      location: location,
      locationId: location.id,
    );
    _places.add(newPlace);
    notifyListeners();
    await _locationRepository.add(location.mapValues);
    await _placeRepository.add(newPlace.mapValues);
  }

  Future<void> fetch() async {
    final listOfPlaces = await _placeRepository.getAll();
    _places = listOfPlaces.map((place) => Place.factory(place)).toList();

    for (var place in _places) {
      final locationMap = await _locationRepository.get({'id' : place.locationId});
      place.location = Location.factory(locationMap);
    }
    notifyListeners();
  }

}