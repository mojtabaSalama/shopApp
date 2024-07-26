import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/cart_provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';

import 'package:shop_app/components/cart_tile.dart';
import 'package:shop_app/components/curser.dart';
import 'package:shop_app/components/pay.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      context.read<CartProvider>().getAll(
          Provider.of<CustomerProvider>(context, listen: false)
              .authCustomer!
              .token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
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
                cartProvider.cartItems.isEmpty
                    ? const SliverFillRemaining(
                        child: Center(
                          child: Text("Your cart is empty"),
                        ),
                      )
                    : context.watch<CartProvider>().isLoading
                        ? const SliverFillRemaining(
                            child: MyCurser(),
                          )
                        : SliverPadding(
                            padding: const EdgeInsetsDirectional.all(15),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final item = cartProvider.cartItems[index];
                                  return MyCartTile(
                                    item: item,
                                    isCart: true,
                                  );
                                },
                                childCount: cartProvider.cartItems.length,
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
            if (cartProvider.cartItems.isNotEmpty) const Pay(),
          ],
        ),
      );
    });
  }
}
