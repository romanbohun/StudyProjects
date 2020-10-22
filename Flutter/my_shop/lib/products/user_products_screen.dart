import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/routes/routes.dart';
import '../providers/products_provider.dart';
import '../common/drawer/app_drawer.dart';
import '../products/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    void addHandler() {
      Navigator.of(context).pushNamed(RouteNames.editUserProduct.routePath);
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addHandler,
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsProvider.items.length,
            itemBuilder: (_, index) {
              var product = productsProvider.items[index];
              return Column(
                children: [
                  UserProductItem(product.title, product.imageUrl),
                  Divider()
                ],
              );
            }
        ),
      ),
    );
  }
}
