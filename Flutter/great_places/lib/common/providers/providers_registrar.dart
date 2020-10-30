import 'package:flutter/widgets.dart';
import 'package:great_places/places/providers/places_provider.dart';
import 'package:provider/provider.dart';

class ProvidersRegistrar extends MultiProvider {

  ProvidersRegistrar({
    Key key,
    Widget child
  }) : super(
    key: key,
    providers: [
      ChangeNotifierProvider(
        create: (ctx) => PlacesProvider(),
      )
    ],
    child: child,
  );
}