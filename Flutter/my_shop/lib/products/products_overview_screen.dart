import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
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
  var _isInit = false;
  var _isDataLoadingInProgress = false;

  @override
  void initState() {
    // Two approaches how to fetch data during screen initialization
    // Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts();
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      setState(() {
        _isDataLoadingInProgress = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetAllProducts()
          .then((result) {

        if (!result.success) {
          print(result.failure.message);
        }
        setState(() {
          _isDataLoadingInProgress = false;
        });
      });
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchAndSetAllProducts();
  }

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
      body: _isDataLoadingInProgress
          ? Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ProductsGrid(_currentFilterOption),
      ),
    );
  }
}