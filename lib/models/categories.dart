import 'dart:convert';
import 'product.dart';

List<Category> categoriesFromJson(String str) => List<Category>.from(json
    .decode(str)
    .cast<String>()
    .map((categoryName) => Category(name: categoryName, imageLink: "")));

class Category {
  String name, imageLink;

  late List<int>? productIds = List.empty(growable: true);
  Category({required this.name, required this.imageLink});

  void getRelatedProducts(List<Product>? products) {
    for (int i = 0; i < products!.length; i++) {
      if (products.elementAt(i).category == name) {
        productIds?.add(i);
      }
    }
  }
}
