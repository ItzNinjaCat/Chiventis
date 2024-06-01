import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool error;

  const CustomTextInput({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: error ? const Color.fromARGB(255, 197, 13, 0) : Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: error ? const Color.fromARGB(255, 197, 13, 0) : const Color(0xFF424242),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: error ? const Color.fromARGB(255, 197, 13, 0) : const Color(0xFF424242),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: error ? const Color.fromARGB(255, 197, 13, 0) : Theme.of(context).primaryColor,
            ),
          ),
          suffixIcon: error
              ? const Icon(
                  Icons.error_outline_outlined,
                  color: Color.fromARGB(255, 197, 13, 0),
                )
              : null,
        ),
        obscureText: isPassword,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: error ? const Color.fromARGB(255, 197, 13, 0) : Colors.black,
        ),
      ),
    );
  }
}
