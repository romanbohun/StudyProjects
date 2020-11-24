import 'package:flutter/foundation.dart';
import 'package:great_places/places/models/coordinates.dart';

class LocationPreview {
  final Coordinates coordinates;
  final String url;

  LocationPreview({
    @required this.coordinates,
    @required this.url
  });
}