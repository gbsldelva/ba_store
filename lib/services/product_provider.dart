import 'package:ba_store/services/utilities.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> products = [];
  List<Product> favoriteProducts = [];
  List<Product> inCartProducts = [];

  void addToFavorites(Product product) async {
    if (!favoriteProducts.contains(product)) {
      favoriteProducts.add(product);
      await Storage.storeIndexes(product.id, '${username}_fav');
      notifyListeners();
    }
  }

  void removeFromFavorites(Product product) {
    if (favoriteProducts.contains(product)) {
      favoriteProducts.remove(product);
      Storage.removeIndex(product.id, '${username}_fav');
      notifyListeners();
    }
  }

  void addToCart(Product product) async {
    if (!inCartProducts.contains(product)) {
      inCartProducts.add(product);
      await Storage.storeIndexes(product.id, '${username}_cart');
      notifyListeners();
    }
  }

  void removeFromCart(Product product) async {
    if (inCartProducts.contains(product)) {
      inCartProducts.remove(product);
      await Storage.removeIndex(product.id, '${username}_cart');
      notifyListeners();
    }
  }
}
