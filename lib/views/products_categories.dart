import 'package:ba_store/views/all_products.dart';
import 'package:ba_store/views/categories_carousel.dart';
import 'package:flutter/material.dart';

import '../services/utilities.dart';

class CategoriesProducts extends StatefulWidget {
  const CategoriesProducts({super.key});

  @override
  State<CategoriesProducts> createState() => _CategoriesProductsState();
}

class _CategoriesProductsState extends State<CategoriesProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Text(
              'Top Categories',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
              height: 200,
              child: CategoriesCarousel(
                  categories: GlobalVariables.categoriesList)),
          const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              'Top Products',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
              height: 280,
              child: AllProducts(
                topProductsOnly: true,
              )),
        ],
      ),
    );
  }
}
