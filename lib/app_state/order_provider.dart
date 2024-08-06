import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shop_app/api/order_api.dart';
import 'package:shop_app/models/item.dart';
import 'package:shop_app/models/order.dart';

class OrderProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Order> orders = [];
  List<Item> orderItems = [];

  Future<dynamic> getAll(String token) async {
       changeLodingStatus();
    http.Response response = await ApiOrder.getAll(token);

    if (response.statusCode == 200) {
     
      Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> apiOrders = responseBody["orders"];
      orders =
          List<Order>.from(apiOrders.map((order) => Order.fromJson(order)));
   changeLodingStatus();
      notifyListeners();

      return true;
    } else {
         changeLodingStatus();
     
      return json.decode(response.body);
    }
  }

  Future<dynamic> getByID(data) async {
       changeLodingStatus();
    http.Response response = await ApiOrder.getById(data);

    if (response.statusCode == 200) {
    
      Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> apiItems = responseBody["order_items"];
      orderItems = List<Item>.from(apiItems.map((item) => Item.fromJson(item)));
   changeLodingStatus();
      notifyListeners();

      return true;
    } else {
     changeLodingStatus();
      return json.decode(response.body);
    }
  }
  void changeLodingStatus() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
