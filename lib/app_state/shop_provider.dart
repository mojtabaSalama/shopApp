import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class Shop extends ChangeNotifier {
  final List<Product> _shop = [
    Product(
        description: "this is a product",
        price: 99,
        name: "product 1",
        image: "assets/hat.jpg"),
    Product(
        description: "this is a product",
        price: 99,
        name: "product 2",
        image: "assets/makeup.jpg"),
    Product(
        description: "this is a product",
        price: 99,
        name: "product 3",
        image: "assets/toy.jpg"),
    Product(
        description: "this is a productn ",
        price: 99,
        name: "product 4",
        image: "assets/tshirt.jpg")
  ];

  List<Product> _cart = [];
  double total = 0;
  List<Product> get cart => _cart;
  List<Product> get shop => _shop;

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
