import 'cart.dart';
import 'categorie_product.dart';
import 'package:flutter/material.dart';
import 'favorites.dart';
import '../services/utilities.dart' as util;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 1;
  bool firstRun = true;

  List<Widget> pages = [
    FavoritesList(),
    const CategoriesProducts(category: null),
    CartList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: util.navyBlue,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Favorites",
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "My cart", icon: Icon(Icons.shopping_cart))
          ]),
    );
  }
}
