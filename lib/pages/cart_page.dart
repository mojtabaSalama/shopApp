import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/shop_provider.dart';
import 'package:shop_app/components/cart_tile.dart';
import 'package:shop_app/components/meterial_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void pay(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                  "do you want to pay ${context.read<Shop>().total.toString()} ?"),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<Shop>().resetCart();
                  },
                  child: const Text("Yes"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                elevation: 0,
                floating: true,
                flexibleSpace: const FlexibleSpaceBar(),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(25, 10, 10, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cart ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Manage your cart from here ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              cart.isEmpty
                  ? const SliverFillRemaining(
                      child: Center(
                        child: Text("Your cart is empty"),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsetsDirectional.all(15),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final product = cart[index];
                            return MyCartTile(product: product);
                          },
                          childCount: cart.length,
                        ),
                      ),
                    ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 80, // Space for the button at the bottom
                ),
              ),
            ],
          ),
          if (cart.isNotEmpty)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: MyButtun(
                  width: double.infinity,
                  onTap: () => pay(context),
                  child: Center(
                      child: Text(
                    "PAY NOW",
                    style: TextStyle(
                        letterSpacing: 3,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 17),
                  ))),
            ),
        ],
      ),
    );
  }
}
