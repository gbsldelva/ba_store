import 'dart:math';

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import '../models/categories.dart';
import '../models/product.dart';
import 'api.dart' as api;

class Storage {
  static const String _boxName = 'userBox';
  static const String _tokenKey = 'token';
  static const String _boxFavorites = 'products';

  static Future<void> storeIndexes(int newIndex, String key) async {
    var favoritesBox = await Hive.openBox<String>(_boxFavorites);

    String? storedIndexesString = favoritesBox.get(key) ?? '';
    String newIndexesString = storedIndexesString.isNotEmpty
        ? '$storedIndexesString-$newIndex'
        : '$newIndex';

    await favoritesBox.put(key, newIndexesString);
  }

  static Future<void> removeIndex(int indexToRemove, String key) async {
    var favoritesBox = await Hive.openBox<String>(_boxFavorites);

    String? storedIndexesString = favoritesBox.get(key);
    if (storedIndexesString != null && storedIndexesString.isNotEmpty) {
      List<String> indexesList = storedIndexesString.split('-');
      List<String> updatedIndexesList = indexesList
          .where((index) => int.parse(index) != indexToRemove)
          .toList();

      String newIndexesString = updatedIndexesList.join('-');
      await favoritesBox.put(key, newIndexesString);
    }
  }

  static Future<String?> retrieveIndexes(String key) async {
    var favoritesBox = await Hive.openBox<String>(_boxFavorites);

    String? storedIndexesString = favoritesBox.get(key);
    return storedIndexesString;
  }

  static Future<List<Product>> getStoredProducts(String key) async {
    String indexes = await retrieveIndexes(key) ?? "";
    List<int> indexList =
        indexes.split("-").map((index) => int.parse(index)).toList();

    List<Product> selectedProducts = [];
    for (int i = 0; i < indexList.length; i++) {
      selectedProducts.add(GlobalVariables.productsList[indexList[i] - 1]);
    }
    return selectedProducts;
  }

  static Future<void> saveUserData(String username, String token) async {
    final box = await Hive.openBox(_boxName);
    await box.put("username", username);
    await box.put(_tokenKey, token);
  }

  static Future<String?> getUsername() async {
    final box = await Hive.openBox(_boxName);
    return box.get("username") as String?;
  }

  static Future<String?> getToken() async {
    final box = await Hive.openBox(_boxName);
    return box.get(_tokenKey) as String?;
  }

  static Future<void> logOutUser() async {
    final box = await Hive.openBox(_boxName);
    await box.delete("username");
    await box.delete("token");
    username = "admin";
  }
}

const Color navyBlue = Color(0xFF042e60);
String username = "admin";
bool reloadRequired = false;

List<Product> sortProducts(List<Product> products) {
  // Sort the products based on rating in descending order
  products.sort((a, b) => b.rate.compareTo(a.rate));

  // If two products have the same rating, sort them based on count in descending order
  products.sort((a, b) {
    if (a.rate == b.rate) {
      return b.count.compareTo(a.count);
    }
    return 0;
  });

  return products;
}

class GlobalVariables {
  static List<Product> productsList = List.empty(growable: true);
  static List<Product> favoriteProducts = List.empty(growable: true);
  static List<Product> productsInCart = List.empty(growable: true);
  static List<Category> categoriesList = List.empty(growable: true);
  static Future<void> getFavoriteProducts() async {
    if (username == "admin") {
      favoriteProducts = <Product>[];
    } else {
      favoriteProducts = await Storage.getStoredProducts('${username}_fav');
    }
  }

  static Future<void> getProductsInCart() async {
    if (username == "admin") {
      productsInCart = <Product>[];
    } else {
      productsInCart = await Storage.getStoredProducts('${username}_cart');
    }
  }

  static List<Category> getCategories() {
    return categoriesList;
  }

  static updateCategories() {
    for (int i = 0; i < categoriesList.length; i++) {
      categoriesList[i].getRelatedProducts(productsList);
    }

    for (int i = 0; i < categoriesList.length; i++) {
      var currentCategory = categoriesList[i];
      var index = Random().nextInt(currentCategory.productIds?.length ?? 0);
      index = currentCategory.productIds?.elementAt(index) ?? 0;
      var link = productsList.elementAt(index).image;
      currentCategory.imageLink = link;
      categoriesList[i] = currentCategory;
    }
  }

  static Future<void> fetchCategories() async {
    categoriesList = await api.APIService.getCategories() ?? <Category>[];
  }
}
