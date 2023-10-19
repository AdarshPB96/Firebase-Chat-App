import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const TextfieldWidget({
    required this.text,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: text),
    );
  }
}
