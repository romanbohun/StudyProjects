import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {

    void removeItemHandler(DismissDirection direction) {
      Provider.of<CartProvider>(context, listen: false).removeItem(productId);
    }

    void onNegativeActionHandler() {
      Navigator.of(context).pop(false);
    }

    void onPosititveActionHandler() {
      Navigator.of(context).pop(true);
    }

    Future<bool> confirmRemoving(DismissDirection direction) {
      return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove item  from the cart?'),
            actions: [
              FlatButton(
                child: Text('No'),
                onPressed: onNegativeActionHandler,
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: onPosititveActionHandler,
              )
            ],
          )
      );
    }

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: confirmRemoving,
      onDismissed: removeItemHandler,
      child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FittedBox(
                    child: Text('\$$price'),
                  ),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total: \$${quantity * price}'),
              trailing: Text('$quantity x'),
            ),
          )
      ),
    );
  }
}
