import 'dart:convert';

import 'package:great_places/places/models/coordinates.dart';
import 'package:great_places/places/models/location_preview.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationService {

  Future<LocationPreview> generateLocationPreviewImageUrlForCurrentLocation() async {
    final locationData = await Location().getLocation();
    return generateLocationPreviewImageUrl(latitude: locationData.latitude, longitude: locationData.longitude);
  }

  LocationPreview generateLocationPreviewImageUrl({double latitude, double longitude}) {
    final coordinates = Coordinates(latitude: latitude, longitude: longitude);
    return LocationPreview(coordinates: coordinates, url: 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap'+
    '&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$_googleApiKey');
  }

  Future<Coordinates> getCurrentLocationCoordinates() async {
    final locationData = await Location().getLocation();
    return Coordinates(latitude: locationData.latitude, longitude: locationData.longitude);
  }

  Future<String> getPlaceAddress({double latitude, double longitude}) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_googleApiKey';
    final response = await http.get(url);
    final body = json.decode(response.body);
    final listOfResults = body['results'] as List<dynamic>;
    if ( listOfResults != null && listOfResults.length > 0) {
      return listOfResults[0]['formatted_address'];
    }
    return null;
  }
}