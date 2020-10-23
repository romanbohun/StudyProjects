import 'dart:convert';
import 'package:flutter/foundation.dart';

class Product  with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false
  });

  Product.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        title = json['title'],
        description = json['description'],
        price = double.parse(json['price']),
        imageUrl = json['imageUrl'],
        isFavorite = json['isFavorite'];

  Product.withId(String id, Product product) :
        id = id,
        title = product.title,
        description = product.description,
        price = product.price,
        imageUrl = product.imageUrl,
        isFavorite = product.isFavorite;


  String toJson() => json.encode({
    'title': title,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
    'isFavorite': isFavorite,
  });

}