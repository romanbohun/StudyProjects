import 'package:flutter/material.dart';
import 'package:great_places/common/routes/routes.dart';
import 'package:great_places/places/providers/places_provider.dart';
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
      body: Consumer<PlacesProvider> (
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
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(place.image),
                ),
                title: Text(place.title),
                onTap: _itemSelectedHandler,
              );
            }
        ),
      ),
    );
  }
}
