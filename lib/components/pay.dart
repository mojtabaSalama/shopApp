import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/cart_provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';

import 'package:shop_app/components/meterial_button.dart';
import 'package:shop_app/components/snackbar.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  void pay(BuildContext context, data) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                  "do you want to pay ${context.read<CartProvider>().totalPrice.toString()} ?"),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                MaterialButton(
                  onPressed: () async {
                    final response =
                        await context.read<CartProvider>().create(data);
                    if (response == true) {
                      showMySnackbar(context, "Order completed!");
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

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: MyButtun(
          width: double.infinity,
          onTap: () {
            pay(context, context.read<CustomerProvider>().authCustomer!.token);
          },
          child: Center(
              child: Text(
            "PAY NOW",
            style: TextStyle(
                letterSpacing: 3,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 17),
          ))),
    );
  }
}
