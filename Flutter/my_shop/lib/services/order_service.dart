import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/errors/p_error.dart';
import '../models/order.dart';
import '../common/classes/result.dart';
import '../services/firebase_service.dart';
import '../models/product.dart';

class OrderService extends FirebaseService {
  String _currentUrl;

  OrderService() {
    _currentUrl = super.baseUrl + '/orders';
  }

  String _ordersUrl() {
    return '$_currentUrl.json';
  }

  // Future<Result<List<Order>>> fetch() async {
  //   try {
  //     final url = _ordersUrl();
  //     final response = await http.get(url);
  //     if (response.statusCode != 200) {
  //       return errorRequestResult(response);
  //     }
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     final List<Order> loadedOrders = [];
  //     extractedData.forEach((orderId, orderData) {
  //       loadedOrders.add(Product.fromJson(prodId, prodData));
  //     });
  //     return Result(success: loadedProducts, failure: null);
  //   } catch (error) {
  //     return Result(success: null, failure: PError(message: 'Something went wrong during the request. Please try again later!'));
  //   }
  // }

  Future<Result<Order>> add(Order order) async {
    try {
      final url = _ordersUrl();
      final response = await http.post(
          url,
          body: order.toJson()
      );
      if (response.statusCode != 200) {
        // A user-oriented error message should be provided here
        return errorRequestResult(response);
      }
      final obtainedId = json.decode(response.body)['name'];
      return Result.successful(data: Order.withId(obtainedId, order));

    } catch (error) {
      return overallRequestError(error);
    }
  }

}