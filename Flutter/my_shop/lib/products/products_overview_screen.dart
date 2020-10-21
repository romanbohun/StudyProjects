import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../products/products_grid.dart';
import '../providers/enums/filter_options.dart';
import '../common/widgets/badge.dart';
import '../common/drawer/app_drawer.dart';
import '../common/routes/routes.dart';
import '../providers/cart_provider.dart';


class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _currentFilterOption = FilterOptions.All;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                _currentFilterOption = selectedValue;
              });
            },
            icon: Icon(Icons.more_vert,),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites',),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All',),
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteNames.cart.routePath);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_currentFilterOption),
    );
  }
}