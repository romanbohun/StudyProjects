import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_shop/common/errors/p_error.dart';

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

  Result _errorRequestResult(http.Response response) {
    return Result(success: null, failure: PError(message: response.reasonPhrase.toString()));
  }

  Result _errorDuringRequest(Error error) {
    return Result(success: null, failure: PError(message: 'Something went wrong during the request. Please try again later!'));
  }

  Future<Result<List<Product>>> fetchProducts() async {
    try {
      final url = _productsUrl();
      final response = await http.get(url);
      if (response.statusCode != 200) {
        return _errorRequestResult(response);
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product.fromJson(prodId, prodData));
      });
      return Result(success: loadedProducts, failure: null);
    } catch (error) {
      return Result(success: null, failure: PError(message: 'Something went wrong during the request. Please try again later!'));
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
        return _errorRequestResult(response);
      }
      final obtainedId = json.decode(response.body)['name'];
      return Result(success: Product.withId(obtainedId, product), failure: null);

    } catch (error) {
      return Result(success: null, failure: PError(message: 'Something went wrong during the request. Please try again later!'));
    }
  }

  Future<Result<bool>> update(Product product) async {
    final url = _productUrl(product.id);
    try{
      final response = await http.patch(
          url,
          body: product.toJson()
      );

      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return _errorRequestResult(response);
      }
      return Result(success: true, failure: null);
    } catch (error) {
      return Result(success: false, failure: PError(message: 'Something went wrong during the request. Please try again later!'));
    }
  }

  Future<Result<bool>> delete(String id) async {
    final url = _productUrl(id);
    try{
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return _errorRequestResult(response);
      }
      return Result(success: true, failure: null);
    } catch (error) {
      return Result(success: false, failure: PError(message: 'Something went wrong during the request. Please try again later!'));
    }
  }

}