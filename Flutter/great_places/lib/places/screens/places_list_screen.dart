import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/common/routes/routes.dart';
import 'package:great_places/places/providers/place_provider.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {

  void _addHandler(BuildContext context ) {
    Navigator.of(context).pushNamed(RouteNames.addPlace.routePath);
  }

  void _itemSelectedHandler() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addHandler(context),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context, listen: false).fetch(),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<PlaceProvider> (
          child: Center(
            child: const Text('Got on places yet, start adding some!'),
          ),
          builder: (ctx, placesProvider, child) =>
          placesProvider.places.length == 0
              ? child
              : ListView.builder(
              itemCount: placesProvider.places.length,
              itemBuilder: (ctx, index) {
                final place = placesProvider.places[index];
                final file = new File(place.filePath);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(file),
                  ),
                  title: Text(place.title),
                  onTap: _itemSelectedHandler,
                );
              }
          ),
        ),
      ),
    );
  }
}
