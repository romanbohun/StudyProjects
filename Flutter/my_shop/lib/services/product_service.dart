import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/errors/p_error.dart';
import '../common/classes/result.dart';
import '../services/firebase_service.dart';
import '../models/product.dart';

class ProductService extends FirebaseService {
  String _currentUrl;

  ProductService() {
    _currentUrl = super.baseUrl + '/products';
  }

  String _productsUrl() {
    return '$_currentUrl.json';
  }

  String _productUrl(String id) {
    return '$_currentUrl/$id.json';
  }

  Future<Result<List<Product>>> fetch() async {
    try {
      final url = _productsUrl();
      final response = await http.get(url);
      if (response.statusCode != 200) {
        return errorRequestResult(response);
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product.fromJson(prodId, prodData));
      });
      return Result.successful(data: loadedProducts);
    } catch (error) {
      return overallRequestError(error);
    }
  }

  Future<Result<Product>> add(Product product) async {
    try {
      final url = _productsUrl();
      final response = await http.post(
          url,
          body: product.toJson()
      );
      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return errorRequestResult(response);
      }
      final obtainedId = json.decode(response.body)['name'];
      return Result.successful(data: Product.withId(obtainedId, product));

    } catch (error) {
      return overallRequestError(error);
    }
  }

  Future<Result> update(Product product) async {
    final url = _productUrl(product.id);
    try{
      final response = await http.patch(
          url,
          body: product.toJson()
      );

      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return errorRequestResult(response);
      }
      return Result.successful();
    } catch (error) {
      return overallRequestError(error);
    }
  }

  Future<Result> delete(String id) async {
    final url = _productUrl(id);
    try{
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return errorRequestResult(response);
      }
      return Result.successful();
    } catch (error) {
      return overallRequestError(error);
    }
  }

  Future<Result> toggleFavoriteFor(String id, bool value) async {
    final url = _productUrl(id);
    try{
      final response = await http.patch(
          url,
          body: json.encode({
            'isFavorite': value
          })
      );

      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return errorRequestResult(response);
      }
      return Result.successful();
    } catch (error) {
      return overallRequestError(error);
    }
  }

}