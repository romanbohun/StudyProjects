import 'package:flutter/material.dart';
import 'package:my_shop/common/classes/result.dart';

import '../services/product_service.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final _productService = ProductService();

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

  Future<Result<bool>> toggleFavorite() async {
    final oldValue = _product.isFavorite;
    _product.isFavorite = !_product.isFavorite;
    notifyListeners();
    final result = await _productService.toggleFavoriteFor(id, _product.isFavorite);

    if (!result.success) {
      _product.isFavorite = oldValue;
      notifyListeners();
    }
    return result;
  }

}
