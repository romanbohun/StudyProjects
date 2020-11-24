import 'package:flutter/material.dart';
import 'package:great_places/common/screens/map_screen.dart';
import 'package:great_places/common/services/location_service.dart';

class LocationInput extends StatefulWidget {
  final locationService = LocationService();

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final currentLocationUrl = await widget.locationService.generateLocationPreviewImageUrlForCurrentLocation();
    setState(() {
      _previewImageUrl = currentLocationUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context)
        .push(
        MaterialPageRoute(
          builder: (ctx) => MapScreen(isEditable: true,),
        )
    );

    if (selectedLocation == null) {
      return;
    }
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
            child: _previewImageUrl == null
                ? Text(
              'No Location Chosen',
              textAlign: TextAlign.center,
            )
                : Image.network(
              _previewImageUrl,
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
