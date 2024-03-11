import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  const PhoneInputField(
    this.controller, {
    super.key,
  });

  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Phone no.",
      ),
      onTapOutside: (x) => FocusScope.of(context).unfocus(),
      keyboardType: TextInputType.number,
      maxLength: 13,
      controller: controller,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        letterSpacing: 5,
      ),
    );
  }
}
