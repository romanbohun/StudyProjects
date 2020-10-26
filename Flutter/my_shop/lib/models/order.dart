import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime
  });
  //
  // Order.fromJson(String id, Map<String, dynamic> json) :
  //       id = id,
  //       amount = json['amount'] as double,
  //       dateTime = json['imageUrl'] as DateTime,
  //       isFavorite = json['isFavorite'] as bool;

  String toJson() => json.encode({
    'amount': amount,
    'dateTime': dateTime.toIso8601String(),
    'products': products.map((cartItem) => cartItem.toMap()).toList(),
  });

  Order.withId(String id, Order order) :
        id = id,
        amount = order.amount,
        products = order.products,
        dateTime = order.dateTime;

}