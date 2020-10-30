import 'package:flutter/material.dart';
import 'package:great_places/common/routes/routes.dart';

class PlacesListScreen extends StatelessWidget {

  void _addHandler(BuildContext context ) {
    Navigator.of(context).pushNamed(RouteNames.addPlace.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addHandler(context),
          )
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
