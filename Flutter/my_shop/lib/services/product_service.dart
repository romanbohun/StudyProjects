import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/classes/result.dart';
import '../services/firebase_service.dart';
import '../models/product.dart';

class ProductService extends FirebaseService {
  String _currentUrl;

  ProductService() {
    _currentUrl = super.baseUrl + '/products.json';
  }

  Future<Result<Product, String>> add(Product product) {
    return http.post(
        _currentUrl,
        body: product.toJson()
    ).then((value) {
      if (value.statusCode != 200) {
        // A user-oriented error message should be provided here
        return Result(success: null, failure: value.reasonPhrase.toString());
      }
      final obtainedId = json.decode(value.body)['name'];
      return Result(success: Product.withId(obtainedId, product), failure: null);
    })
    .catchError((error) {
      return Result(success: null, failure: 'Something went wrong during the request. Please try again later!');
    });
  }
}