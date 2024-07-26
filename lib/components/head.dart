import 'package:flutter/material.dart';

class Head extends StatelessWidget {
  final String head;
  final String subhead;
  const Head({super.key, required this.head, required this.subhead});

  @override
  Widget build(BuildContext context) {
    return //form head
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: TextStyle(
            fontSize: 25,
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        //secondery head
        Text(
          subhead,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ],
    );
  }
}
