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
                  OrderButton(cartProvider: cartProvider)
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartProvider,
  }) : super(key: key);

  final CartProvider cartProvider;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    Future<void> orderNowButtonHandler() async {
      setState(() {
        _isLoading = true;
      });

      final result = await Provider.of<OrdersProvider>(context, listen: false).addOrder(
        widget.cartProvider.items.values.toList(),
        widget.cartProvider.totalAmount,
      );

      if (result.failure != null) {
        scaffold.hideCurrentSnackBar();
        scaffold.showSnackBar(
            SnackBar(
              content: Text(result.failure.message),
            )
        );
      } else {
        widget.cartProvider.clear();
      }
      setState(() {
        _isLoading = false;
      });
    }

    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text(
        'ORDER NOW',
      ),
      textColor: Theme.of(context).primaryColor,
      onPressed: (widget.cartProvider.totalAmount <= 0 || _isLoading == true) ?
      null :
      orderNowButtonHandler,
    );
  }
}
