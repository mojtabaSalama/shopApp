import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/cart_provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';

class RemoveItem extends StatefulWidget {
  final String id;

  const RemoveItem({super.key, required this.id});

  @override
  State<RemoveItem> createState() => _RemoveItemState();
}

class _RemoveItemState extends State<RemoveItem> {
  void removeFromCart(BuildContext context, data) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text("Remove the item from cart?"),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<CartProvider>().remove(data);
                  },
                  child: const Text("Yes"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          final data = {
            'token': context.read<CustomerProvider>().authCustomer!.token,
            'id': widget.id,
          };

          removeFromCart(context, data);
        },
        icon: const Icon(Icons.remove_circle_outline_sharp));
  }
}
