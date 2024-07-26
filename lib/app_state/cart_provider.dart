import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/api/cart_api.dart';
import 'package:shop_app/api/order_api.dart';
import 'package:shop_app/models/item.dart';

class CartProvider extends ChangeNotifier {
  bool isLoading = false;

  List<Item> cartItems = [];
  double? totalPrice;

  Future<dynamic> add(data) async {
    isLoading = true;
    http.Response response = await ApiCart.addToCart(data);

    if (response.statusCode == 201) {
      isLoading = false;
      notifyListeners();

      return true;
    } else {
      isLoading = false;
      return response.body;
    }
  }

  Future<dynamic> getAll(String token) async {
    isLoading = true;
    http.Response response = await ApiCart.getAll(token);

    if (response.statusCode == 200) {
      isLoading = false;
      Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> items = responseBody["cartItems"];
      cartItems = List<Item>.from(items.map((item) => Item.fromJson(item)));

      totalPrice = double.parse(responseBody["totalPrice"].toString());

      notifyListeners();

      return true;
    } else {
      isLoading = false;
      return response.body;
    }
  }

  Future<dynamic> remove(Map data) async {
    isLoading = true;
    http.Response response = await ApiCart.removeFromCart(data);

    if (response.statusCode == 200) {
      isLoading = false;
      getAll(data["token"]);

      notifyListeners();

      return true;
    } else {
      isLoading = false;
      return response.body;
    }
  }

  Future<dynamic> update(Map data) async {
    isLoading = true;
    http.Response response = await ApiCart.update(data);

    if (response.statusCode == 200) {
      isLoading = false;
      getAll(data["token"]);

      notifyListeners();

      return true;
    } else {
      isLoading = false;
      return response.body;
    }
  }

  Future<dynamic> create(data) async {
    isLoading = true;
    http.Response response = await ApiOrder.placeOrder(data);

    if (response.statusCode == 201) {
      isLoading = false;
      cartItems = [];
      notifyListeners();

      return true;
    } else {
      isLoading = false;
      return response.body;
    }
  }
}
