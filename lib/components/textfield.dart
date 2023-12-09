import 'package:flutter/material.dart';

TextFormField textfield(TextEditingController controller, String placeholder,
    {bool obscure = false}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: Colors.black, letterSpacing: 1),
    obscureText: obscure,
    decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Colors.black45),
        contentPadding: const EdgeInsets.all(10),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white))),
  );
}
