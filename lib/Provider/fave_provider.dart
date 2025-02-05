import 'package:flutter/material.dart';

class FavoProvider extends ChangeNotifier {
  final Map<String, bool> _favorites = {};
  Map<String, bool> get favorites => _favorites;

  //toggle favorites
  void toggleFavorites(String productID) {
    if (_favorites.containsKey(productID)) {
      _favorites[productID] = !_favorites[productID]!;
    } else {
      _favorites[productID] = true;
    }
    print("add new");
    notifyListeners();
  }

  //isFavorite
  bool isFavorites(String productid) {
    return _favorites[productid] ?? false;
  }
}
