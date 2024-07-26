import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class Shop extends ChangeNotifier {


  List<Product> _cart = [];
  double total = 0;
  List<Product> get cart => _cart;


  void addToCart(Product item) {
    _cart.add(item);
    total += item.price;
    notifyListeners();
  }

  void removeFromCart(Product item) {
    _cart.remove(item);
    total -= item.price;
    notifyListeners();
  }

  void resetCart() {
    _cart = [];
    total = 0;
    notifyListeners();
  }
}
