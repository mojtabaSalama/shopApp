import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/app_state/shop_provider.dart';
import 'package:shop_app/components/actions_row.dart';
import 'package:shop_app/components/drawer.dart';
import 'package:shop_app/components/meterial_button.dart';
import 'package:shop_app/components/product_tile.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Shop>().shop;
    final cutomerProvider = context.watch<CustomerProvider>();
    return Scaffold(
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: cutomerProvider.authCustomer == null
                    ? const ActionsRow()
                    : Row(
                        children: [
                          Text(
                            cutomerProvider.authCustomer!.name,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          MyButtun(
                              onTap: () {
                                Navigator.pushNamed(context, "/cartPage");
                              },
                              child: Icon(
                                Icons.shopping_cart,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ))
                        ],
                      ),
              )
            ],
            elevation: 0,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Your Market",
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(25, 10, 10, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shop",
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
                    "Pick from the top quality products",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.all(15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Display two products in each row
                mainAxisSpacing: 10,
                crossAxisSpacing: 2,
                childAspectRatio: 0.45,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final product = products[index];
                  return MyProductTile(product: product);
                },
                childCount: products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
