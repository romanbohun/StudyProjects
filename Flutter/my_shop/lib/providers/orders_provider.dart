import 'package:flutter/foundation.dart';
import 'package:my_shop/common/classes/result.dart';
import 'package:my_shop/services/order_service.dart';

import '../models/order.dart';
import '../models/cart_item.dart';

class OrdersProvider with ChangeNotifier {
  final _orderService = OrderService();

  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<Result<Order>> addOrder(List<CartItem> cartProducts, double total) async {
    // _orders.insert(
    //     0,
    //     Order(
    //       id: DateTime.now().toString(),
    //       amount: total,
    //       dateTime: DateTime.now(),
    //       products: cartProducts,
    //     )
    // );
    // notifyListeners();

    final order = Order(
      amount: total,
      dateTime: DateTime.now(),
      products: cartProducts,
    );

    return await _orderService.add(order)
        .then((result) {
      if (result.failure == null) {
        _orders.insert(0, result.success);
        notifyListeners();
      }
      return result;
    });
  }

}