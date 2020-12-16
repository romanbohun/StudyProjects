import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/common/helpers/googlemap_helper.dart';
import 'package:great_places/places/models/coordinates.dart';
import 'package:great_places/places/models/location.dart';

class MapScreen extends StatefulWidget {
  final Location location;
  final bool isEditable;

  MapScreen({
    this.location,
    this.isEditable = false
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Future<CameraPosition> coordinates;

  LatLng _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  void _confirm() {
    Navigator.of(context).pop(_pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    if (coordinates == null) {
      coordinates = CameraPositionHelper.getCameraPositionByLocation(widget.location);
    }
    return FutureBuilder(
      future: coordinates,
      builder: (ctx, snapshot) =>
      snapshot.connectionState == ConnectionState.waiting
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Scaffold(
        appBar: AppBar(
          title: Text('Your Map'),
          actions: [
            if (widget.isEditable) IconButton(
                icon: Icon(Icons.check),
                onPressed: _confirm,
            )
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: snapshot.data,
          onTap: widget.isEditable ? _selectLocation : null,
          markers: _pickedLocation == null
              ? null
              : { Marker(markerId: MarkerId('m1'), position: _pickedLocation) },
        ),
      ),
    );
  }
}
