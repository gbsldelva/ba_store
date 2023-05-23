import 'package:ba_store/services/utilities.dart' as util;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../services/product_provider.dart';
import 'ask_to_login.dart';

class CartList extends StatefulWidget {
  CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    List<Product> inCartProducts =
        context.watch<ProductProvider>().inCartProducts;
    return Scaffold(
        body: Visibility(
      visible: util.username != "admin",
      replacement: LoginPrompt(),
      child: inCartProducts.isEmpty
          ? const Center(
              child: Text('The products in cart will be displayed here'),
            )
          : ListView.builder(
              itemCount: inCartProducts.length,
              padding: const EdgeInsets.only(top: 8.0),
              itemBuilder: (BuildContext context, int index) {
                final product = inCartProducts[index];
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
                        context.read<ProductProvider>().removeFromCart(product);
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
