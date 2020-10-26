import 'dart:convert';

class CartItem {
  final String id;
  final String title;
  final double price;
  int quantity;

  CartItem({
    this.id,
    this.title,
    this.price,
    this.quantity
  });

  String toJson() => json.encode({
    'id': id,
    'title': title,
    'price': price,
    'quantity': quantity
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'price': price,
    'quantity': quantity
  };

}