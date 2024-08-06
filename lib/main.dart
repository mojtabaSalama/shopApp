import 'package:flutter/material.dart';
import 'package:shop_app/app_state/cart_provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/app_state/order_provider.dart';
import 'package:shop_app/app_state/product_provider.dart';

import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/pages/intro_page.dart';

import 'package:shop_app/pages/order_page.dart';
import 'package:shop_app/pages/shop_page.dart';
import 'package:shop_app/pages/siginup.dart';
import 'package:shop_app/pages/signin.dart';
import 'package:shop_app/theme/light_mode.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          home: const IntroPage(),
          theme: lightMode,
          routes: {
            '/introPage': (context) => const IntroPage(),
            '/shopPage': (context) => const ShopPage(),
            '/cartPage': (context) => const CartPage(),
            '/orderPage': (context) => const OrderPage(),
            '/signUp': (context) => const SignUp(),
            '/signIn': (context) => const SignIn(),
          }),
    );
  }
}
