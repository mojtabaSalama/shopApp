import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/app_state/order_provider.dart';

import 'package:shop_app/components/cart_tile.dart';
import 'package:shop_app/components/curser.dart';
import 'package:shop_app/components/snackbar.dart';
import 'package:shop_app/models/order.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();

    Map data = {
      "token": Provider.of<CustomerProvider>(context, listen: false)
          .authCustomer!
          .token,
      "id": widget.order.id
    };
    SchedulerBinding.instance.scheduleFrameCallback((_) async {
      final response = await context.read<OrderProvider>().getByID(data);
      if (response != true) {
        showMySnackbar(context, response);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: context.read<OrderProvider>().isLoading
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.order.id.substring(0, 8),
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.order.createdAt
                                  .toString()
                                  .substring(0, 19))
                            ],
                          ),
                          Text(
                            "Total Amount : ${widget.order.totalAmount}",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                          Text(
                            "Total Price : ${widget.order.totalPrice} \$",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.all(15),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final item = orderProvider.orderItems[index];
                          return MyCartTile(
                            item: item,
                            isCart: false,
                          );
                        },
                        childCount: orderProvider.orderItems.length,
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
