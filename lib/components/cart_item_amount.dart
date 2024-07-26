import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_state/cart_provider.dart';
import 'package:shop_app/app_state/customer_provider.dart';
import 'package:shop_app/components/meterial_button.dart';
import 'package:shop_app/components/snackbar.dart';

class ItemAmount extends StatefulWidget {
  final String amount;
  final String itemId;
  const ItemAmount({super.key, required this.amount, required this.itemId});

  @override
  State<ItemAmount> createState() => _ItemAmountState();
}

class _ItemAmountState extends State<ItemAmount> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController amountController = TextEditingController();
    amountController.text = widget.amount;
    return Row(
      children: [
        Text(
          "Amount :",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 60,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: amountController,
            cursorColor: Theme.of(context).colorScheme.inversePrimary,
            onEditingComplete: () {
              setState(() {
                isvisible = false;
              });
            },
            onTap: () {
              setState(() {
                isvisible = true;
              });
            },
          ),
        ),
        if (isvisible)
          MyButtun(
              onTap: () async {
                if (int.tryParse(amountController.text) == null) {
                  showMySnackbar(context, "Amount should be a number");
                } else {
                  final data = {
                    'token':
                        context.read<CustomerProvider>().authCustomer!.token,
                    'id': widget.itemId,
                    "amount": double.parse(amountController.text)
                  };

                  final response =
                      await Provider.of<CartProvider>(context, listen: false)
                          .update(data);

                  if (response == true) {
                    showMySnackbar(context, "Product added!");
                  } else {
                    showMySnackbar(context, response);
                  }
                }
              },
              child: const Text("Update"))
      ],
    );
  }
}
