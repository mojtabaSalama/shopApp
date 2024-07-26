import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/api/urls.dart';

class ApiOrder {
  static Future getAll(token) async {
    try {
      Map<String, String> configHeaders = {
        "Content-Type": "application/json",
        "token": token
      };

      final url = Uri.parse(orderUrl);

      http.Response response = await http.get(url, headers: configHeaders);

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      rethrow;
    }
  }

  static Future placeOrder(token) async {
    try {
      Map<String, String> configHeaders = {
        "Content-Type": "application/json",
        "token": token
      };

      final url = Uri.parse("${orderUrl}create");

      http.Response response = await http.post(url, headers: configHeaders);

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      rethrow;
    }
  }

  static Future getById(Map data) async {
    try {
      Map<String, String> configHeaders = {
        "Content-Type": "application/json",
        "token": data["token"]
      };

      final url = Uri.parse("$orderUrl${data["id"]}");

      http.Response response = await http.get(url, headers: configHeaders);

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      return http.Response("Internal error , try again later ", 500);
    }
  }
}
