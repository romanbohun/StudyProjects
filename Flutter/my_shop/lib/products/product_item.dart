import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/routes/routes.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final scaffold = Scaffold.of(context);

    void undoHandler() {
      cartProvider.removeSingleItem(product.id);
    }

    void addItemHandler() {
      cartProvider.addItem(product.id, product.price, product.title);
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${product.title} added to the cart',
            ),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: undoHandler,
            ),
          )
      );
    }

    Future<void> toggleFavoriteHandler() async {
      final result = await product.toggleFavorite();

      if (!result.success) {
        scaffold.hideCurrentSnackBar();
        scaffold.showSnackBar(
            SnackBar(
              content: Text(result.failure.message),
            )
        );
      }
    }

    void navigateToDetailsHandler() {
      Navigator.of(context).pushNamed(
          RouteNames.productDetails.routePath,
          arguments: product.id
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: navigateToDetailsHandler,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<ProductProvider>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: toggleFavoriteHandler,
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: addItemHandler,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
