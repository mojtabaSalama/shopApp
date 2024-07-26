import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/cart_provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';

import 'package:shop_app/components/snackbar.dart';

import 'package:shop_app/models/product.dart';

class MyProductTile extends StatefulWidget {
  final Product product;
  const MyProductTile({super.key, required this.product});

  @override
  State<MyProductTile> createState() => _MyProductTileState();
}

class _MyProductTileState extends State<MyProductTile> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldMessengerState>();
    void addToCart(BuildContext context, token) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: const Text("Add this item to cart ?"),
                actions: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      final data = {
                        'token': token,
                        'id': widget.product.id,
                      };

                      final response = await Provider.of<CartProvider>(context,
                              listen: false)
                          .add(data);

                      if (response == true) {
                        showMySnackbar(context, "Product added!");
                      } else {
                        showMySnackbar(context, response);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text("Yes"),
                  )
                ],
              ));
    }

    final cutomerProvider = context.watch<CustomerProvider>();
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: NetworkImage(widget.product.image),
                          fit: BoxFit.cover)),

                  width: double.infinity,
                  // child: const Icon(Icons.favorite)
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.product.description,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${widget.product.price.toString()}'),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                      onPressed: () => cutomerProvider.authCustomer != null
                          ? addToCart(
                              context, cutomerProvider.authCustomer!.token)
                          : showMySnackbar(
                              context,
                              "Sign in to access the cart",
                            ),
                      icon: const Icon(Icons.add_shopping_cart)))
            ],
          ),
        ],
      ),
    );
  }
}
