import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../products/product_item.dart';
import '../providers/products_provider.dart';
import '../providers/enums/filter_options.dart';

class ProductsGrid extends StatelessWidget {
  final FilterOptions filterOption;

  ProductsGrid(this.filterOption);

  @override
  Widget build(BuildContext context) {
    final productsDataProvider = Provider.of<ProductsProvider>(context);
    final products = filterOption == FilterOptions.All ?
    productsDataProvider.items :
    productsDataProvider.favoriteItems;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        final product = products[index];
        return ChangeNotifierProvider.value(
          value: product,
          child: ProductItem(),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
