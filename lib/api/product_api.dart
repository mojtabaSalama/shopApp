import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/api/urls.dart';

class ApiProduct {
  static Future getAll() async {
    try {
      Map<String, String> configHeaders = {"Content-Type": "application/json"};

      final url = Uri.parse(fetchProcucts);

      http.Response response = await http.get(url, headers: configHeaders);

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      return http.Response("Internal error , try again later ", 500);
    }
  }
}
