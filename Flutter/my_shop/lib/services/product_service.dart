import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/classes/result.dart';
import '../services/firebase_service.dart';
import '../models/product.dart';
import '../common/extensions/string_extensions.dart';

class ProductService extends FirebaseService {
  String _currentUrl;

  ProductService(String token, String userId) : super(token: token, userId: userId) {
    _currentUrl = super.baseUrl + '/products';
  }

  String _productsUrl() {
    return '$_currentUrl.json'
        .addToken(token);
  }

  String _productUrl(String id) {
    return '$_currentUrl/$id.json'
        .addToken(token);
  }

  String _productFavoriteUrl(String id) {
    return '$baseUrl/users/$userId/favorites/$id.json'
        .addToken(token);
  }

  String _userFavoriteProductsUrl() {
    return '$baseUrl/users/$userId/favorites/.json'
        .addToken(token);
  }

  Future<Result<List<Product>>> fetch() async {
    try {
      final url = _productsUrl();
      final response = await http.get(url);
      if (response.statusCode != 200) {
        return errorRequestResult(response);
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return Result.successful(data: []);
      }

      final favoritesResponse = await _getFavorites();
      Map<String, dynamic> favorites = {};
      if (favoritesResponse.success) {
        favorites = favoritesResponse.data;
      }

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        var product = Product.fromJson(prodId, prodData);
        product.isFavorite = favorites[product.id] ?? false;
        loadedProducts.add(product);
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
    final url = _productFavoriteUrl(id);
    try{
      final response = await http.put(
          url,
          body: json.encode(value)
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

  Future<Result<Map<String, dynamic>>> _getFavorites() async {
    try {
      final url = _userFavoriteProductsUrl();
      final response = await http.get(url);
      if (response.statusCode != 200) {
        return errorRequestResult(response);
      }
      final extractedData = json.decode(response.body);
      return Result.successful(data: extractedData == null ? {} : extractedData);
    } catch (error) {
    return overallRequestError(error);
    }
  }

}