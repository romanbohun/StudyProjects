import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:great_places/common/services/location_service.dart';
import 'package:great_places/places/models/coordinates.dart';
import 'package:great_places/places/models/location.dart';

class CameraPositionHelper {

  static Future<CameraPosition> getCameraPositionByLocation(Location location, {double zoom = 16}) async {
    Coordinates coordinates;

    if (location == null) {
      coordinates = await LocationService().getCurrentLocationCoordinates();
    } else {
      coordinates = Coordinates(latitude: location.latitude, longitude: location.longitude);
    }

    return CameraPosition(
        target: LatLng(coordinates.latitude, coordinates.longitude),
        zoom: zoom
    );
  }

}