import 'package:flutter/material.dart';

TextField basicTextField(
    String text, TextEditingController controller, bool isPassword) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      filled: true,
    ),
    obscureText: isPassword,
  );
}
