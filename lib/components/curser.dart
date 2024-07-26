import 'package:flutter/material.dart';

class MyCurser extends StatelessWidget {
  const MyCurser({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.grey,
    ));
  }
}
