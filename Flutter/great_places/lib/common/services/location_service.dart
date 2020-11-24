import 'package:great_places/places/models/coordinates.dart';
import 'package:location/location.dart';

class LocationService {
  final _googleApiKey = 'AIzaSyBdkhjqvYIPNlBdFfKAlZ3cW-aI8vQN1PQ';

  Future<String> generateLocationPreviewImageUrlForCurrentLocation() async {
    final locationData = await Location().getLocation();
    return generateLocationPreviewImageUrl(latitude: locationData.latitude, longitude: locationData.longitude);
  }

  String generateLocationPreviewImageUrl({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap'+
    '&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$_googleApiKey';
  }

  Future<Coordinates> getCurrentLocationCoordinates() async {
    final locationData = await Location().getLocation();
    return Coordinates(latitude: locationData.latitude, longitude: locationData.longitude);
  }

}