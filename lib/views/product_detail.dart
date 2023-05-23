import 'package:ba_store/services/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/product_provider.dart';
import 'package:ba_store/services/utilities.dart' as util;
import 'package:ba_store/views/ask_to_login.dart';

class ProductDetailPage extends StatelessWidget {
  final Product? product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> inCartProducts =
        context.watch<ProductProvider>().inCartProducts;
    return Scaffold(
      appBar: AppBar(
        title: Text(product!.title),
        backgroundColor: navyBlue,
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          if (util.username == "admin") {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const LoginPrompt()));
          } else {
            if (!inCartProducts.contains(product)) {
              context.read<ProductProvider>().addToCart(product ??
                  Product(
                      id: 21,
                      title: "title",
                      category: "category",
                      description: "description",
                      image: "image",
                      price: 30.0,
                      rate: 30,
                      count: 30));
            } else {
              context.read<ProductProvider>().removeFromCart(product ??
                  Product(
                      id: 21,
                      title: "title",
                      category: "category",
                      description: "description",
                      image: "image",
                      price: 30.0,
                      rate: 30,
                      count: 30));
            }
          }
        },
        icon: Icon(
          Icons.shopping_cart,
          size: 50,
          color: inCartProducts.contains(product) ? Colors.red : util.navyBlue,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    product!.image,
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                product!.title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const SizedBox(height: 8.0),
              Text(
                product!.description,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Price: \$${product!.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Rating: ${product!.rate}/5.0 (${product!.count} votes)',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
