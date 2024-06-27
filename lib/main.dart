import 'package:flutter/material.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/app_state/shop_provider.dart';

import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/pages/intro_page.dart';
import 'package:shop_app/pages/shop_page.dart';
import 'package:shop_app/pages/siginup.dart';
import 'package:shop_app/pages/signin.dart';
import 'package:shop_app/theme/light_mode.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Shop()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const IntroPage(),
          theme: lightMode,
          routes: {
            '/introPage': (context) => const IntroPage(),
            '/shopPage': (context) => const ShopPage(),
            '/cartPage': (context) => const CartPage(),
            '/signUp': (context) => const SignUp(),
            '/signIn': (context) => const SignIn(),
          }),
    );
  }
}
