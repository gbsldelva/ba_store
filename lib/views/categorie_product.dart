import 'package:ba_store/models/categories.dart';
import 'package:ba_store/views/all_products.dart';
import 'package:ba_store/views/categories_carousel.dart';
import 'package:ba_store/views/reusable_widgets.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/utilities.dart';

@immutable
class CategoriesProducts extends StatefulWidget {
  final Category? category;
  const CategoriesProducts({super.key, required this.category});

  @override
  State<CategoriesProducts> createState() =>
      _CategoriesProductsState(category: category);
}

class _CategoriesProductsState extends State<CategoriesProducts> {
  Category? category;
  _CategoriesProductsState({required this.category});
  String _categoryText = 'Top Categories';
  String _productsText = 'Top Products';

  Widget categoryCarousel =
      CategoriesCarousel(categories: GlobalVariables.categoriesList);
  double _heightProducts = 280;
  List<Product> productsDisplayed = [];

  @override
  Widget build(BuildContext context) {
    if (category != null) {
      _categoryText = category?.name.toUpperCase() ?? "";
      _productsText = 'Available products';
      _heightProducts = 360;
      categoryCarousel = CarouselCard(
              category: category ??
                  Category(name: category?.name ?? "", imageLink: ""))
          .container;
    }

    return Scaffold(
      appBar: category != null ? const CustomAppBar() : null,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Visibility(
              visible: category == null,
              child: Text(
                _categoryText,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 200, child: categoryCarousel),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              _productsText,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: _heightProducts,
            child: AllProducts(
              categoryName: category?.name,
              topProductsOnly: category?.name == null ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}
