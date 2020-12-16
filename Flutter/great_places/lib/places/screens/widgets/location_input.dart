import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/common/screens/map_screen.dart';
import 'package:great_places/common/services/location_service.dart';
import 'package:great_places/places/models/location_preview.dart';

class LocationInput extends StatefulWidget {
  final Function onPlaceSelected;
  final locationService = LocationService();

  LocationInput(this.onPlaceSelected);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationPreview _locationPreview;

  Future<LocationPreview> _getLocationPreviewForCurrentLocation() async {
    return await widget.locationService.generateLocationPreviewImageUrlForCurrentLocation();
  }

  Future<LocationPreview> _getLocationPreviewForCoordinates({
    double latitude,
    double longitude
  }) async {
    return await widget.locationService.generateLocationPreviewImageUrl(
        latitude: latitude,
        longitude: longitude
    );
  }

  Future<void> _getCurrentLocation() async {
    final currentLocationPreview = await _getLocationPreviewForCurrentLocation();

    setState(() {
      _locationPreview = currentLocationPreview;
    });

    final address = await widget.locationService
        .getPlaceAddress(
      latitude: currentLocationPreview.coordinates.latitude,
      longitude: currentLocationPreview.coordinates.longitude,
    );

    widget.onPlaceSelected(
        currentLocationPreview.coordinates.latitude,
        currentLocationPreview.coordinates.longitude,
        address
    );
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context)
        .push<LatLng>(
        MaterialPageRoute(
          builder: (ctx) => MapScreen(isEditable: true,),
        )
    );

    if (selectedLocation == null) {
      return;
    }

    final locationPreview = await _getLocationPreviewForCoordinates(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude
    );

    setState(() {
      _locationPreview = locationPreview;
    });

    final address = await widget.locationService
        .getPlaceAddress(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );

    widget.onPlaceSelected(selectedLocation.latitude, selectedLocation.longitude, address);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                )
            ),
            child: _locationPreview == null
                ? Text(
              'No Location Chosen',
              textAlign: TextAlign.center,
            )
                : Image.network(
              _locationPreview.url,
              fit: BoxFit.cover,
              width: double.infinity,
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
