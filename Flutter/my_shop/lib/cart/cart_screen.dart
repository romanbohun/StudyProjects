import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart/cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    Widget createOrderItem(BuildContext ctx, int index) {
      var cartItem = cartProvider.items.values.toList()[index];
      var cartProductId = cartProvider.items.keys.toList()[index];
      return CartItem(
          cartItem.id,
          cartProductId,
          cartItem.price,
          cartItem.quantity,
          cartItem.title
      );
    }

    void orderNowButtonHandler() {
      Provider.of<OrdersProvider>(context, listen: false).addOrder(
        cartProvider.items.values.toList(),
        cartProvider.totalAmount,
      );
      cartProvider.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      'ORDER NOW',
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: orderNowButtonHandler,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cartProvider.itemCount,
                itemBuilder: createOrderItem,
            ),
          ),
        ],
      ),
    );
  }
}
