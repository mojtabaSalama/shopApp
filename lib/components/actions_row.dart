import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/components/meterial_button.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cutomerProvider = context.watch<CustomerProvider>();
    return cutomerProvider.authCustomer == null
        ? Row(
            children: [
              MyButtun(
                  onTap: () => Navigator.pushNamed(context, '/signIn'),
                  child: const Text("Sign in")),
              const SizedBox(
                width: 5,
              ),
              MyButtun(
                  onTap: () => Navigator.pushNamed(context, '/signUp'),
                  child: const Text("Sign up"))
            ],
          )
        : Row(children: [
            TextButton(
                onPressed: () => Navigator.pushNamed(context, '/orderPage'),
                child: Text(
                  cutomerProvider.authCustomer!.customerName,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary),
                )),
            const SizedBox(
              width: 3,
            ),
            MyButtun(
                onTap: () {
                  Navigator.pushNamed(context, "/cartPage");
                },
                child: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ))
          ]);
  }
}
