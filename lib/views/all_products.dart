import 'package:ba_store/services/utilities.dart' as util;
import 'package:ba_store/views/ask_to_login.dart';
import 'package:ba_store/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../services/product_provider.dart';

@immutable
class AllProducts extends StatefulWidget {
  final String? categoryName;
  final bool topProductsOnly;
  const AllProducts(
      {super.key, this.categoryName, required this.topProductsOnly});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = context.watch<ProductProvider>().products;
    List<Product> favoriteProducts =
        context.watch<ProductProvider>().favoriteProducts;
    List<Product> inCartProducts =
        context.watch<ProductProvider>().inCartProducts;

    if (widget.categoryName != null) {
      products = products
          .where((element) => element.category == widget.categoryName)
          .toList();
    } else if (widget.topProductsOnly == true) {
      List<Product> sortedProducts = util.sortProducts(products);
      int endIndex = sortedProducts.length > 6 ? 6 : sortedProducts.length;
      products = sortedProducts.sublist(0, endIndex);
    }

    return Scaffold(body: Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 8.0,
                mainAxisExtent: 280.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color.fromARGB(255, 223, 224, 224),
                ),
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                product: products.elementAt(index))));
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0)),
                        child: Image.network(
                          products.elementAt(index).image,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products.elementAt(index).title,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text('Price: ${products.elementAt(index).price} USD'),
                          Text(
                            'Rating: ${products.elementAt(index).rate}/5.0',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                color:
                                    favoriteProducts.contains(products[index])
                                        ? Colors.red
                                        : util.navyBlue,
                                onPressed: () {
                                  if (util.username == "admin") {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPrompt()));
                                  } else {
                                    Product currentProduct = products[index];
                                    if (!favoriteProducts
                                        .contains(currentProduct)) {
                                      context
                                          .read<ProductProvider>()
                                          .addToFavorites(currentProduct);
                                    } else {
                                      context
                                          .read<ProductProvider>()
                                          .removeFromFavorites(currentProduct);
                                    }
                                  }
                                },
                                icon: const Icon(Icons.favorite),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (util.username == "admin") {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPrompt()));
                                  } else {
                                    Product currentProduct = products[index];
                                    if (!inCartProducts
                                        .contains(currentProduct)) {
                                      context
                                          .read<ProductProvider>()
                                          .addToCart(currentProduct);
                                    } else {
                                      context
                                          .read<ProductProvider>()
                                          .removeFromCart(currentProduct);
                                    }
                                  }
                                },
                                color: inCartProducts.contains(products[index])
                                    ? Colors.red
                                    : util.navyBlue,
                                icon: const Icon(Icons.shopping_cart),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ));
  }
}
