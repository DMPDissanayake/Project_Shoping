import 'package:flutter/material.dart';
import 'package:shoping_cart/Models/cart.dart';

class CartProvider extends ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  //Add item
  void addItems(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (update) => CartItem(
          id: update.id,
          title: update.title,
          price: update.price,
          quantity: update.quantity + 1,
        ),
      );
      print("update data");
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      print("new data");
    }
    notifyListeners();
  }

  //removeItem
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  //removeSingelItem
  void removeSingelItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (update) => CartItem(
          id: update.id,
          title: update.title,
          price: update.price,
          quantity: update.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  //allclean
  void allclean() {
    _items = {};
    notifyListeners();
  }

  //calculateTheTotale
  double get calculateTheTotale {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }
}
