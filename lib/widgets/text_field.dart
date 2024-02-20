import 'package:flutter/material.dart';

class FrozitTextField extends StatelessWidget {
  const FrozitTextField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLength,
  });

  final TextEditingController controller;
  final String label;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      controller: controller,
      keyboardType:
          (label == 'Phone') ? TextInputType.phone : TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        prefix: (label == 'Phone') ? const Text('+91 ') : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffE8E8E8),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffE8E8E8),
            width: 1.5,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        fillColor: const Color(0xFFF6F6F6),
        filled: true,
      ),
      maxLength: maxLength,
      onTapOutside: (x) => FocusScope.of(context).unfocus(),
    );
  }
}
