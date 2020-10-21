import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  Product _product;

  ProductProvider(this._product);

  String get id {
    return _product.id;
  }

  String get title {
    return _product.title;
  }

  String get description {
    return _product.description;
  }

  double get price {
    return _product.price;
  }

  String get imageUrl {
    return _product.imageUrl;
  }

  bool get isFavorite {
    return _product.isFavorite;
  }

  void toggleFavorite() {
    _product.isFavorite = !_product.isFavorite;
    notifyListeners();
  }

}
