import 'dart:convert';

import '../models/product.dart';
import '../models/categories.dart';
import 'package:http/http.dart' as http;

class APIService {
  static Future<List<Product>?> getProducts() async {
    var client = http.Client();

    var uri = Uri.parse("https://fakestoreapi.com/products");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return productFromJson(json);
    }
    return null;
  }

  Future<dynamic> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 &&
        jsonDecode(response.body)["token"] != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Category>?> getCategories() async {
    var client = http.Client();

    var uri = Uri.parse("https://fakestoreapi.com/products/categories");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return categoriesFromJson(json);
    }
    return null;
  }
}
