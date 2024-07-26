import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/api/urls.dart';

class ApiCart {
  static Future addToCart(Map data) async {
    try {
      Map<String, String> configHeaders = {
        "Content-Type": "application/json",
        "token": data["token"]
      };

      final url = Uri.parse("${cartUrl}add/${data["id"]}");

      http.Response response = await http.post(url, headers: configHeaders);

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      return http.Response("Internal error , try again later ", 500);
    }
  }

  static Future getAll(token) async {
    try {
      Map<String, String> configHeaders = {
        "Content-Type": "application/json",
        "token": token
      };

      final url = Uri.parse(cartUrl);

      http.Response response = await http.get(url, headers: configHeaders);

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      return http.Response("Internal error , try again later ", 500);
    }
  }

  static Future removeFromCart(Map data) async {
    try {
      Map<String, String> configHeaders = {
        "Content-Type": "application/json",
        "token": data["token"]
      };

      final url = Uri.parse("${cartUrl}remove/${data["id"]}");

      http.Response response = await http.post(url, headers: configHeaders);

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      return http.Response("Internal error , try again later ", 500);
    }
  }

  static Future update(Map data) async {
    try {
      Map<String, String> configHeaders = {
        "Content-Type": "application/json",
        "token": data["token"]
      };

      final url = Uri.parse("${cartUrl}update/${data["id"]}");

      http.Response response =
          await http.post(url, headers: configHeaders, body: jsonEncode(data));

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      return http.Response("Internal error , try again later ", 500);
    }
  }
}
