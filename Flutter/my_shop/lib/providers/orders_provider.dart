import 'package:flutter/foundation.dart';
import 'package:my_shop/common/classes/result.dart';
import 'package:my_shop/services/order_service.dart';

import '../models/order.dart';
import '../models/cart_item.dart';

class OrdersProvider with ChangeNotifier {
  final OrderService _orderService;

  OrdersProvider(this._orderService, this._orders);

  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<Result> fetchAndSet() async {
    return await _orderService.fetch()
        .then((result) {
      if (result.success) {
        _orders.clear();
        _orders.addAll(result.data.reversed);
        notifyListeners();
      }
      return result;
    });
  }

  Future<Result<Order>> addOrder(List<CartItem> cartProducts, double total) async {
    final order = Order(
      amount: total,
      dateTime: DateTime.now(),
      products: cartProducts,
    );

    return await _orderService.add(order)
        .then((result) {
      if (result.success) {
        _orders.insert(0, result.data);
        notifyListeners();
      }
      return result;
    });
  }

}