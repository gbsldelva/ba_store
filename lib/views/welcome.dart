// ignore_for_file: invalid_use_of_protected_member

import 'package:ba_store/services/api.dart';
import 'package:ba_store/views/loading.dart';
import 'package:ba_store/views/main_screen.dart';
import 'package:ba_store/views/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/product_provider.dart';
import '../services/utilities.dart' as util;

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMounted = true; // Flag to track the mounted status

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<List<Product>?>(
          future: APIService.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Data is still loading, display a circular progress indicator
              return const Scaffold(
                appBar: CustomAppBar(),
                drawer: CustomDrawer(),
                body: LoadingScreen(),
              );
            } else if (snapshot.hasError) {
              // Error occurred while fetching data
              return Text('Error: ${snapshot.error}');
            } else {
              // Data loaded successfully, use your custom widget
              List<Product>? products = snapshot.data;
              util.GlobalVariables.productsList = products ?? <Product>[];
              ProductProvider productProvider = context.read<ProductProvider>();
              util.GlobalVariables.updateCategories();
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (isMounted) {
                  // Modifying properties
                  productProvider.products = products ?? <Product>[];
                  await util.GlobalVariables.getFavoriteProducts();
                  await util.GlobalVariables.getProductsInCart();
                  util.GlobalVariables.updateCategories();
                  productProvider.favoriteProducts =
                      util.GlobalVariables.favoriteProducts;
                  productProvider.inCartProducts =
                      util.GlobalVariables.productsInCart;

                  // Notify listeners to trigger a rebuild
                  // ignore: invalid_use_of_visible_for_testing_member
                  productProvider.notifyListeners();
                }
              });

              if (products != null && products.isNotEmpty) {
                return const Scaffold(
                  appBar: CustomAppBar(),
                  drawer: CustomDrawer(),
                  body: MainScreen(),
                );
              } else {
                return const Scaffold(
                  appBar: CustomAppBar(),
                  drawer: CustomDrawer(),
                  body: Center(
                    child: Text(
                        'Unable to get the data, please check you internet connection.'),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
