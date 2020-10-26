import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../common/routes/routes.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({
    this.id,
    this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    void onEditHandler() {
      Navigator.of(context).pushNamed(
          RouteNames.editUserProduct.routePath,
          arguments: id,
      );
    }

    Future<void> onDeleteHandler() async {
      final result = await Provider.of<ProductsProvider>(context, listen: false)
          .deleteProduct(id);

      if (!result.success) {
        scaffold.showSnackBar(
            SnackBar(
              content: Text(result.failure.message),
            )
        );
      }
    }

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEditHandler,
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDeleteHandler,
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
