import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  String hintText;
  int maxLines;
  TextEditingController controller;
  TextFieldWidget({
    required this.hintText,
    required this.maxLines,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.white.withOpacity(0.5),
        ),
        fillColor: const Color(0xFF414141),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
