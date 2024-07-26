import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/components/list_tile.dart';
import 'package:shop_app/components/snackbar.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  void signOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text("Sign out fom app ?"),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/introPage", (route) => false);
                    context.read<CustomerProvider>().signout();
                  },
                  child: const Text("Yes"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = context.watch<CustomerProvider>();
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 72,
                ),
              )),
              const SizedBox(
                height: 25,
              ),
              MyListTile(
                  icon: Icons.home,
                  text: "Shop",
                  onTap: () => Navigator.pop(context)),
              MyListTile(
                  icon: Icons.shopping_cart,
                  text: "Cart",
                  onTap: () {
                    Navigator.pop(context);
                    customerProvider.authCustomer != null
                        ? Navigator.pushNamed(context, "/cartPage")
                        : showMySnackbar(context, "Sign in to access the cart");
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
                icon: Icons.logout,
                text: customerProvider.authCustomer == null
                    ? "Exit"
                    : "Exit and Sign out",
                onTap: () {
                  if (customerProvider.authCustomer != null) {
                    signOut(context);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/introPage", (route) => false);
                  }
                }),
          )
        ],
      ),
    );
  }
}
