import 'package:flutter/material.dart';
import 'package:my_shop/common/classes/result.dart';

import '../services/product_service.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService;

  Product _product;

  ProductProvider(this._productService, this._product);

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

  String get creatorId {
    return _product.creatorId;
  }

  void _setFavorite(bool value) {
    _product.isFavorite = value;
    notifyListeners();
  }

  Future<Result> toggleFavorite() async {
    final oldValue = _product.isFavorite;
    _setFavorite(!_product.isFavorite);
    final result = await _productService.toggleFavoriteFor(id, _product.isFavorite);

    if (!result.success) {
      _setFavorite(oldValue);
    }
    return result;
  }

}
