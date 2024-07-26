import 'package:flutter/material.dart';

class MyButtun extends StatelessWidget {
  final void Function() onTap;
  final Widget child;
  final double? width;
  const MyButtun(
      {super.key, required this.onTap, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          decoration: BoxDecoration(
              color: Colors.white38, borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(10),
          child: child),
    );
  }
}
