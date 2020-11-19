import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:great_places/persistence/base_repository.dart';
import 'package:great_places/persistence/sqflite_connection.dart';

import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  final _repository = BaseRepository<Place>(SQFliteConnection());

  List<Place> _places = [];
  List<Place> get places {
    return [..._places];
  }

  Future<void> addPlace(String title, String pickedFilePath) async {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      filePath: pickedFilePath,
      location: null,
    );
    _places.add(newPlace);
    notifyListeners();
    await _repository.add(newPlace);
  }

}