import 'package:flutter/material.dart';
import 'package:shop_app/components/meterial_button.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
