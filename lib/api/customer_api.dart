import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/api/urls.dart';

class ApiCustomer {
  static Future signIn(data) async {
    try {
      Map<String, String> configHeaders = {"Content-Type": "application/json"};

      final url = Uri.parse("${customerUrl}signIn");

      http.Response response =
          await http.post(url, headers: configHeaders, body: jsonEncode(data));

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      return http.Response("Internal error , try again later ", 500);
    }
  }

  static Future signup(data) async {
    try {
      Map<String, String> configHeaders = {"Content-Type": "application/json"};

      final url = Uri.parse("${customerUrl}signUp");

      http.Response response =
          await http.post(url, headers: configHeaders, body: jsonEncode(data));

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      rethrow;
    }
  }

  static Future getByToken(data) async {
    try {
      Map<String, String> configHeaders = {"Content-Type": "application/json"};

      final url = Uri.parse("${customerUrl}getbyToken");

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
