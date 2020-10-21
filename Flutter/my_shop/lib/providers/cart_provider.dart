import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = Map<String, CartItem>();

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // void addItem(Product product) {
  //   if (_items.containsKey(product.id)) {
  //     _items.update(
  //         product.id,
  //             (existingItem) => CartItem(
  //               id: existingItem.id,
  //               title: existingItem.title,
  //               price: existingItem.price,
  //               quantity: existingItem.quantity + 1
  //             )
  //     );
  //   } else {
  //     _items.putIfAbsent(
  //         product.id,
  //             () => CartItem(
  //               id: product.id,
  //               title: product.title,
  //               price: product.price,
  //               quantity: 1
  //             )
  //     );
  //   }
  // }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
              (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              price: existingItem.price,
              quantity: existingItem.quantity + 1
          )
      );
    } else {
      _items.putIfAbsent(
          productId,
              () => CartItem(
              id: productId,
              title: title,
              price: price,
              quantity: 1
          )
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}