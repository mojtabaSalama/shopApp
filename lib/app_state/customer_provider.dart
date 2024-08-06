import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

      isLoading = false;
      notifyListeners();
      return true;
    } else {
      isLoading = false;
      notifyListeners();
      return response.body;
    }
  }

  Future<dynamic> signIn(data) async {
    changeLodingStatus();
    http.Response response = await ApiCustomer.signIn(data);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      _authCustomer = Customer.fromJson(responseBody);

      changeLodingStatus();
      return true;
    } else {
      changeLodingStatus();
      return response.body;
    }
  }

  bool signout() {
    if (authCustomer != null) {
      _authCustomer = null;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void changeLodingStatus() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
