import 'package:flutter/material.dart';

class FrozitTextField extends StatefulWidget {
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
  State<FrozitTextField> createState() => _FrozitTextFieldState();
}


class _FrozitTextFieldState extends State<FrozitTextField> {
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter ${widget.label}';
        }
        return null;
      },
      controller: widget.controller,
      keyboardType:
          (widget.label == 'Phone') ? TextInputType.phone : TextInputType.text,
      textInputAction: TextInputAction.next,
      obscureText: (widget.label == 'Password') ? _obscureText : false,
      decoration: InputDecoration(
        labelText: widget.label,
        prefix: (widget.label == 'Phone') ? const Text('+91 ') : null,
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
        suffixIcon: (widget.label == 'Password')
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
      maxLength: widget.maxLength,
      onTapOutside: (x) => FocusScope.of(context).unfocus(),
    );
  }
}
