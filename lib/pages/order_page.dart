import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/app_state/order_provider.dart';
import 'package:shop_app/components/curser.dart';

import 'package:shop_app/components/order_tile.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      context.read<OrderProvider>().getAll(
          Provider.of<CustomerProvider>(context, listen: false)
              .authCustomer!
              .token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: orderProvider.isLoading
            ? const MyCurser()
            : CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    elevation: 0,
                    floating: true,
                    flexibleSpace: const FlexibleSpaceBar(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 10, 0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Orders History ",
                            style: TextStyle(
                              fontSize: 25,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "See your previous transactions ",
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  orderProvider.orders.isEmpty
                      ? const SliverFillRemaining(
                          child: Center(
                            child: Text("You didn't make any transaction"),
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsetsDirectional.all(15),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                final order = orderProvider.orders[index];
                                return OrderTile(order: order);
                              },
                              childCount: orderProvider.orders.length,
                            ),
                          ),
                        ),
                ],
              ),
      );
    });
  }
}
