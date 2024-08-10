import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/app_state/product_provider.dart';
import 'package:shop_app/components/cart_item_amount.dart';

import 'package:shop_app/components/remove_cart_item.dart';
import 'package:shop_app/models/item.dart';

class MyCartTile extends StatefulWidget {
  final Item item;
  final bool isCart;
  const MyCartTile({super.key, required this.item, required this.isCart});

  @override
  State<MyCartTile> createState() => _MyCartTileState();
}

class _MyCartTileState extends State<MyCartTile> {
  @override
  Widget build(BuildContext context) {
    final product =
        context.watch<ProductProvider>().getProduct(widget.item.productId)!;
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      // margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(product.image), fit: BoxFit.cover)),
                padding: const EdgeInsets.all(15),
                width: 70,
                height: 120,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  widget.isCart
                      ? ItemAmount(
                          itemId: widget.item.id,
                          amount: widget.item.amount.toString(),
                        )
                      : Text(
                          "Amount : ${widget.item.amount} ",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Unit Price : ${product.price} \$",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Total : ${widget.item.totalPrice} \$",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
          if (widget.isCart) RemoveItem(id: product.id)
        ],
      ),
    );
  }
}
