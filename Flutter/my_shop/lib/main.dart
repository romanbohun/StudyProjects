import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './common/routes/routes.dart';
import './products/products_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        initialRoute: RouteNames.auth.routePath,
        routes: Routes.allRoutes,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              builder: (ctx) => ProductOverviewScreen()
          );
        },
      ),
    );
  }
}