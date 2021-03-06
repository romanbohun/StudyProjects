import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/product_provider.dart';
import '../models/product.dart';
import '../common/classes/result.dart';
import '../services/product_service.dart';

class ProductsProvider with ChangeNotifier {
  final ProductService _productService;

  ProductsProvider(this._productService, this._items) {

  }

  List<ProductProvider> _items = [
    // ProductProvider(
    //     Product(
    //       id: 'p1',
    //       title: 'Red Shirt',
    //       description: 'A red shirt - it is pretty red!',
    //       price: 29.99,
    //       imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     )
    // ),
    // ProductProvider(
    //     Product(
    //       id: 'p2',
    //       title: 'Trousers',
    //       description: 'A nice pair of trousers.',
    //       price: 59.99,
    //       imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     )
    // ),
    // ProductProvider(
    //     Product(
    //       id: 'p3',
    //       title: 'Yellow Scarf',
    //       description: 'Warm and cozy - exactly what you need for the winter.',
    //       price: 19.99,
    //       imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //     )
    // ),
    // ProductProvider(
    //     Product(
    //       id: 'p4',
    //       title: 'A Pan',
    //       description: 'Prepare any meal you want.',
    //       price: 49.99,
    //       imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //     )
    // ),
  ];

  List<ProductProvider> get items {
    return [..._items];
  }

  List<ProductProvider> _userItems = [];
  List<ProductProvider> get userItems {
    return [..._userItems];
  }

  List<ProductProvider> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<Result<Product>> addProduct(Product newProduct) {
    final product = Product.withCreatorId(_productService.userId, newProduct);
    return _productService.add(product)
        .then((result) {
      if (result.success) {
        _items.add(ProductProvider(this._productService, result.data));
        notifyListeners();
      }
      return result;
    });
  }

  Future<Result> fetchAndSetAllProducts() async {
    return await _productService.fetchAllProducts()
      .then((result) {
      if (result.success) {
        _items.clear();
        result.data.forEach((product) {
          _items.add(ProductProvider(this._productService, product));
        });
        notifyListeners();
      }
      return result;
    });
  }

  Future<Result> fetchUserProducts() async {
    return await _productService.fetchUserProducts()
        .then((result) {
      if (result.success) {
        _userItems.clear();
        result.data.forEach((product) {
          _userItems.add(ProductProvider(this._productService, product));
        });
        notifyListeners();
      }
      return result;
    });
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<Result> updateProduct(Product value) async {
    // final product = Product.withCreatorId(_productService.userId, value);
    return await _productService.update(value)
        .then((result) {
      if (result.success) {
        final foundIndex = _items.indexWhere((element) => element.id == value.id);
        if (foundIndex >= 0) {
          _items[foundIndex] = ProductProvider(this._productService, value);
          notifyListeners();
        }
      }
      return result;
    });
  }

  Future<Result> deleteProduct(String id) async {
    return await _productService.delete(id)
      .then((result) {
      if (result.success) {
        _items.removeWhere((element) => element.id == id);
        notifyListeners();
      }
      return result;
    });
  }

}