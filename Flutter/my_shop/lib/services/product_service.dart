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

  Future<Result<List<Product>, String>> fetchProducts() async {
    try {
      final response = await http.get(_currentUrl);
      if (response.statusCode != 200) {
        return Result(success: null, failure: response.reasonPhrase.toString());
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product.fromJson(prodId, prodData));
      });
      return Result(success: loadedProducts, failure: null);
    } catch (error) {
      return Result(success: null, failure: 'Something went wrong during the request. Please try again later!');
    }
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