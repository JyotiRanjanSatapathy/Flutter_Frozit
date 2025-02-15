import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DottedTextField extends StatelessWidget {
  const DottedTextField({
    super.key,
    required this.controller,
    required this.onFieldChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onFieldChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: -10, left: -5),
          ),
          style: const TextStyle(
            letterSpacing: 30,
            fontSize: 40,
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onChanged: onFieldChanged,
          maxLength: 6,
        ),
        const DottedLine(
          dashLength: 30,
          dashGapLength: 25,
          lineThickness: 2,
        ),
      ],
    );
  }
}
