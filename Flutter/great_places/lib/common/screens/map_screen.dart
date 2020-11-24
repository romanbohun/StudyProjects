import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/common/helpers/googlemap_helper.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CameraPositionHelper.getCameraPositionByLocation(widget.location),
      builder: (ctx, snapshot) =>
      snapshot.connectionState == ConnectionState.waiting
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Scaffold(
        appBar: AppBar(
          title: Text('Your Map'),
        ),
        body: GoogleMap(
          initialCameraPosition: snapshot.data,
        ),
      ),
    );
  }
}
