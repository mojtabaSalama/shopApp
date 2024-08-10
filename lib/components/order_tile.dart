import 'package:flutter/material.dart';

import 'package:shop_app/models/order.dart';
import 'package:shop_app/pages/order_details_page.dart';

class OrderTile extends StatefulWidget {
  final Order order;
  const OrderTile({super.key, required this.order});

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Code : ${widget.order.id.substring(0, 8)}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Total Amount : ${widget.order.totalAmount}",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          Text(
            "Total Price : ${widget.order.totalPrice} \$",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          Text(
            widget.order.createdAt.toString().substring(0, 19),
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailsPage(order: widget.order)));
              },
              child: const Text(
                "Details >",
              ))
        ],
      ),
    );
  }
}
