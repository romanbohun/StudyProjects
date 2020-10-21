import '../../cart/cart_screen.dart';
import '../../orders/orders_screen.dart';
import '../../products/product_details_screen.dart';
import '../../products/products_overview_screen.dart';

enum RouteNames {
  root,
  productDetails,
  cart,
  orders,
}

extension RoutesNameExtension on RouteNames {

  String get routePath {
    switch (this) {
      case RouteNames.root:
        return '/';
      case RouteNames.productDetails:
        return '/product-details';
      case RouteNames.cart:
        return '/cart';
      case RouteNames.orders:
        return '/orders';
    }

    return '';
  }
}

class Routes {
  static final allRoutes = {
    RouteNames.root.routePath: (ctx) => ProductOverviewScreen(),
    RouteNames.productDetails.routePath: (ctx) => ProductDetailsScreen(),
    RouteNames.cart.routePath: (ctx) => CartScreen(),
    RouteNames.orders.routePath: (ctx) => OrdersScreen(),
  };
}