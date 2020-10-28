import 'package:flutter/material.dart';
import 'package:my_shop/services/order_service.dart';
import 'package:my_shop/services/product_service.dart';
import 'package:provider/provider.dart';

import './common/routes/routes.dart';
import './products/products_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';
import './providers/auth_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          update: (ctx, auth, previousProductProvider) =>
              ProductsProvider(
                  ProductService(auth.token, auth.userId),
                  previousProductProvider == null ? [] : previousProductProvider.items,
              ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          update: (ctx, auth, previousOrdersProvider) =>
              OrdersProvider(
                OrderService(auth.token, auth.userId),
                previousOrdersProvider == null ? [] : previousOrdersProvider.orders
              ),
        ),
      ],
      child:Consumer<AuthProvider>(
        builder: (ctx, authProvider, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          initialRoute: authProvider.isAuth
              ? RouteNames.root.routePath
              : RouteNames.auth.routePath,
          routes: Routes.allRoutes,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
                builder: (ctx) => ProductOverviewScreen()
            );
          },
        ),
      ),
    );
  }
}