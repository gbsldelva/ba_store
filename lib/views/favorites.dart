import 'package:ba_store/services/utilities.dart' as util;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../services/product_provider.dart';
import 'ask_to_login.dart';

class FavoritesList extends StatefulWidget {
  FavoritesList({Key? key}) : super(key: key);

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    List<Product> favoriteProducts =
        context.watch<ProductProvider>().favoriteProducts;
    return Scaffold(
        body: Visibility(
      visible: util.username != "admin",
      replacement: LoginPrompt(),
      child: favoriteProducts.isEmpty
          ? const Center(
              child: Text('Your favorite products will be displayed here'),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              padding: const EdgeInsets.only(top: 8.0),
              itemBuilder: (BuildContext context, int index) {
                final product = favoriteProducts[index];
                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Text(
                      '${product.category} - \$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                      onPressed: () {
                        context
                            .read<ProductProvider>()
                            .removeFromFavorites(product);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              },
            ),
    ));
  }
}
