import 'dart:convert';
import 'package:flutter/foundation.dart';

class Product  with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  final String creatorId;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.creatorId,
    this.isFavorite = false
  });

  Product.fromJson(String id, Map<String, dynamic> json) :
        id = id,
        title = json['title'],
        description = json['description'],
        price = json['price'] as double,
        imageUrl = json['imageUrl'],
        creatorId = json['creatorId'],
        isFavorite = false;

  Product.withId(String id, Product product) :
        id = id,
        title = product.title,
        description = product.description,
        price = product.price,
        imageUrl = product.imageUrl,
        isFavorite = product.isFavorite,
        creatorId = product.creatorId;

  Product.withCreatorId(String creatorId, Product product) :
        id = product.id,
        title = product.title,
        description = product.description,
        price = product.price,
        imageUrl = product.imageUrl,
        isFavorite = product.isFavorite,
        creatorId = creatorId;


  String toJson() => json.encode({
    'title': title,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
    'creatorId': creatorId
  });

}