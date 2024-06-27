import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData icon;
  final bool isPassword;

  const MyTextField({
    Key? key,
    required this.keyboardType,
    required this.hintText,
    required this.validator,
    required this.controller,
    required this.isPassword,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 50),
        const SizedBox(width: 5),
        Expanded(
          child: TextFormField(
            obscureText: isPassword,
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: Theme.of(context).colorScheme.secondary,
            decoration: InputDecoration(
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 2.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
