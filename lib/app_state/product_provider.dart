import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shop_app/api/product_api.dart';
import 'package:shop_app/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;
  bool isLoading = false;

  Future<dynamic> get() async {
    changeLodingStatus();
    http.Response response = await ApiProduct.getAll();

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      _products = List<Product>.from(
          responseBody["products"].map((x) => Product.fromJson(x)));
      changeLodingStatus();

      notifyListeners();

      return true;
    } else {
      isLoading = false;
      notifyListeners();
      return response.body;
    }
  }

  Product? getProduct(String productId) {
    try {
      return products.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null; // or handle the case where the product is not found
    }
  }

  void changeLodingStatus() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
