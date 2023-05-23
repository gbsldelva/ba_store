import 'package:ba_store/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:ba_store/views/payment.dart';
import 'package:provider/provider.dart';
import '../services/product_provider.dart';
import '../services/utilities.dart' as util;
import 'all_products.dart';
import 'login_page.dart';
import 'package:flutter/foundation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconButton? leading;

  const CustomAppBar({super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Ba Store"),
      leading: leading,
      actions: util.username != "admin"
          ? [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PaymentMethodPage()));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      "Pay",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ]
          : const [
              IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ))
            ],
      backgroundColor: util.navyBlue,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  CustomAppBar cloneWithChild(Widget child) {
    return CustomAppBar(leading: leading);
  }

  @override
  DiagnosticsNode toDiagnosticsNode(
      {String? name, DiagnosticsTreeStyle? style}) {
    return DiagnosticsNode.message(name ?? 'CustomAppBar');
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'CustomAppBar';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomAppBar &&
          runtimeType == other.runtimeType &&
          leading == other.leading;

  @override
  int get hashCode => leading.hashCode;
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: <Widget>[
          Visibility(
            visible: util.username != "admin",
            child: UserAccountsDrawerHeader(
              accountName: Text(
                util.username,
              ),
              accountEmail: null,
              currentAccountPicture: GestureDetector(
                child: const CircleAvatar(
                  foregroundColor: util.navyBlue,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
              ),
              decoration: const BoxDecoration(color: util.navyBlue),
            ),
          ),
          Visibility(
            visible: util.username == "admin",
            child: InkWell(
              onTap: () async {
                Navigator.pop(context);
                await util.GlobalVariables.getFavoriteProducts();
                await util.GlobalVariables.getProductsInCart();
                ProductProvider productProvider =
                    // ignore: use_build_context_synchronously
                    context.read<ProductProvider>();
                // Modifying properties
                productProvider.favoriteProducts =
                    util.GlobalVariables.favoriteProducts;
                productProvider.inCartProducts =
                    util.GlobalVariables.productsInCart;
                //productProvider.inCartProducts = updatedInCartProducts;
                // Notify listeners to trigger a rebuild
                // ignore: invalid_use_of_visible_for_testing_member
                productProvider.notifyListeners();

                // ignore: use_build_context_synchronously
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const ListTile(
                title: Text('Log In'),
                leading: Icon(
                  Icons.login,
                  color: util.navyBlue,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const Scaffold(
                    appBar: CustomAppBar(),
                    body: Padding(
                      padding: EdgeInsets.all(12),
                      child: AllProducts(
                        topProductsOnly: false,
                      ),
                    ),
                  );
                }),
              );
            },
            child: const ListTile(
              title: Text('All products'),
              leading: Icon(
                Icons.list,
                color: util.navyBlue,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('Home Page'),
              leading: Icon(
                Icons.home,
                color: util.navyBlue,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('Favorites'),
              leading: Icon(
                Icons.favorite,
                color: util.navyBlue,
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('Settings'),
              leading: Icon(
                Icons.settings,
                color: util.navyBlue,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('About'),
              leading: Icon(
                Icons.help,
                color: util.navyBlue,
              ),
            ),
          ),
          Visibility(
            visible: util.username != "admin",
            child: InkWell(
              onTap: () async {
                util.reloadRequired = true;
                await util.Storage.logOutUser();
                await util.GlobalVariables.getFavoriteProducts();
                ProductProvider productProvider =
                    // ignore: use_build_context_synchronously
                    context.read<ProductProvider>();
                // Modifying properties
                productProvider.favoriteProducts =
                    util.GlobalVariables.favoriteProducts;
                productProvider.inCartProducts =
                    util.GlobalVariables.productsInCart;
                // Notify listeners to trigger a rebuild
                // ignore: invalid_use_of_visible_for_testing_member
                productProvider.notifyListeners();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Welcome()),
                    (Route<dynamic> route) => false);
              },
              child: const ListTile(
                title: Text('Log Out'),
                leading: Icon(
                  Icons.exit_to_app,
                  color: util.navyBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
