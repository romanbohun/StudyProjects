import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/product_provider.dart';
import '../models/product.dart';
import '../common/classes/result.dart';
import '../services/product_service.dart';

class ProductsProvider with ChangeNotifier {
  final _productService = ProductService();

  List<ProductProvider> _items = [
    ProductProvider(
        Product(
          id: 'p1',
          title: 'Red Shirt',
          description: 'A red shirt - it is pretty red!',
          price: 29.99,
          imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        )
    ),
    ProductProvider(
        Product(
          id: 'p2',
          title: 'Trousers',
          description: 'A nice pair of trousers.',
          price: 59.99,
          imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        )
    ),
    ProductProvider(
        Product(
          id: 'p3',
          title: 'Yellow Scarf',
          description: 'Warm and cozy - exactly what you need for the winter.',
          price: 19.99,
          imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
        )
    ),
    ProductProvider(
        Product(
          id: 'p4',
          title: 'A Pan',
          description: 'Prepare any meal you want.',
          price: 49.99,
          imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
        )
    ),
  ];

  List<ProductProvider> get items {
    return [..._items];
  }

  List<ProductProvider> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<Result<Product, String>> addProduct(Product value) {
    return _productService.add(value)
        .then((result) {
      if (result.failure == null) {
        final product = Product(
            id: DateTime.now().toString(),
            title: value.title,
            price: value.price,
            description: value.description,
            imageUrl: value.imageUrl
        );

        _items.add(ProductProvider(product));
        notifyListeners();
      }
      return result;
    });
  }

  Future<Result<bool, String>> fetchAndSetProducts() async {
    return await _productService.fetchProducts()
      .then((result) {
      if (result.failure == null) {
        _items.clear();
        result.success.forEach((product) {
          _items.add(ProductProvider(product));
        });
        notifyListeners();
        return Result(success: true, failure: null);
      }
      return Result(success: false, failure: result.failure);
    });
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<Result<bool, String>> updateProduct(Product value) async {
    return _productService.update(value)
        .then((result) {
      if (result.success) {
        final foundIndex = _items.indexWhere((element) => element.id == value.id);
        if (foundIndex >= 0) {
          _items[foundIndex] = ProductProvider(value);
          notifyListeners();
        }
      }
      return result;
    });
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

}