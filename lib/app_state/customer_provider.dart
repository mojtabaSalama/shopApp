import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/api/customer_api.dart';
import 'package:shop_app/models/customer.dart';

class CustomerProvider extends ChangeNotifier {
  Customer? _authCustomer;

  Customer? get authCustomer => _authCustomer;
  bool isLoading = false;

  Future<dynamic> signUp(data) async {
    isLoading = true;
    http.Response response = await ApiCustomer.signup(data);

    if (response.statusCode == 201) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      _authCustomer = Customer.fromJson(responseBody);

      setSharedPrefrences(
          _authCustomer!.token, _authCustomer!.customerName, _authCustomer!.id);

      changeLodingStatus();

      return true;
    } else {
      changeLodingStatus();
      return response.body;
    }
  }

  Future<dynamic> signIn(data) async {
    changeLodingStatus();
    http.Response response = await ApiCustomer.signIn(data);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      _authCustomer = Customer.fromJson(responseBody);
      setSharedPrefrences(
          _authCustomer!.token, _authCustomer!.customerName, _authCustomer!.id);

      changeLodingStatus();

      return true;
    } else {
      changeLodingStatus();
      return response.body;
    }
  }

  void signout() async {
    changeLodingStatus();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("customerName");
    prefs.remove("id");
    changeLodingStatus();
  }

  void changeLodingStatus() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> setSharedPrefrences(token, customerName, id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("customerName", customerName);

    await prefs.setString("token", token);
    await prefs.setString("id", id);
  }

  void getSharedPrefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      final customerName = prefs.getString("customerName");
      final token = prefs.getString("token");
      final id = prefs.getString("id");
      _authCustomer =
          Customer(customerName: customerName!, token: token!, id: id!);
    }
  }
}
