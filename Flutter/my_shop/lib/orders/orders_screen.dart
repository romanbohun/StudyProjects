import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import '../common/drawer/app_drawer.dart';
import '../orders/order_item.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isInit = false;
  var _isDataLoadingInProgress = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      setState(() {
        _isDataLoadingInProgress = true;
      });
      Provider.of<OrdersProvider>(context, listen: false)
          .fetchAndSet()
          .then((_) {
        setState(() {
          _isDataLoadingInProgress = false;
        });
      });
      _isInit = true;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: _isDataLoadingInProgress
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (ctx, index) => OrderItem(ordersProvider.orders[index]),
      ),
    );
  }
}
