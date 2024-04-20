import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextform extends StatelessWidget {
  String label;
  TextEditingController controller;

  MyTextform(
      {super.key,
      required this.label,
      required TextInputType type,
      required this.controller,
      required bool obscure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        });
  }
}
