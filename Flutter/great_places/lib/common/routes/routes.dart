import '../../places/screens/add_place_screen.dart';

enum RouteNames {
  root,
  addPlace,
}

extension RoutesNameExtension on RouteNames {

  String get routePath {
    switch (this) {
      case RouteNames.root:
        return '/';
      case RouteNames.addPlace:
        return '/add-place';
    }

    return '';
  }
}

class Routes {
  static final allRoutes = {
    RouteNames.addPlace.routePath: (ctx) => AddPlaceScreen(),
  };
}