import 'package:flutter/material.dart';

import 'package:shop_app/components/meterial_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Your Market",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Get the best shopping experience !",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(
              height: 25,
            ),
            MyButtun(
                onTap: () => Navigator.pushNamed(context, '/shopPage'),
                child: const Icon(Icons.arrow_forward))
          ],
        ),
      ),
    );
  }
}
