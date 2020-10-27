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

  CartItem.fromJson(Map<String, dynamic> json) :
        id = json['title'],
        title = json['title'],
        price = json['price'] as double,
        quantity = json['quantity'] as int;

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