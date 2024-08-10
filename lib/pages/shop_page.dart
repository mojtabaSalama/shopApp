import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/product_provider.dart';

import 'package:shop_app/components/actions_row.dart';
import 'package:shop_app/components/curser.dart';
import 'package:shop_app/components/drawer.dart';
import 'package:shop_app/components/head.dart';
import 'package:shop_app/components/product_tile.dart';
import 'package:shop_app/components/snackbar.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.scheduleFrameCallback((_) async {
      final response = await context.read<ProductProvider>().get();
      if (response != true) {
        showMySnackbar(context, response);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
      return Scaffold(
        drawer: const MyDrawer(),
        body: productProvider.isLoading
            ? const MyCurser()
            : CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    actions: const [
                      Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: ActionsRow())
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
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(25, 10, 10, 0),
                    sliver: SliverToBoxAdapter(
                        child: Head(
                            head: "Shop",
                            subhead: "Pick from the top quality products")),
                  ),
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.all(15),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Display two products in each row
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 2,
                        childAspectRatio: 0.45,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final product = productProvider.products[index];
                          return MyProductTile(product: product);
                        },
                        childCount: productProvider.products.length,
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
