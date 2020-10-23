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

  Future<Result<Product, String>> add(Product product) async {
    try {
      final response = await http.post(
          _currentUrl,
          body: product.toJson()
      );
      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return Result(success: null, failure: response.reasonPhrase.toString());
      }
      final obtainedId = json.decode(response.body)['name'];
      return Result(success: Product.withId(obtainedId, product), failure: null);

    } catch (error) {
      return Result(success: null, failure: 'Something went wrong during the request. Please try again later!');
    }
  }
}