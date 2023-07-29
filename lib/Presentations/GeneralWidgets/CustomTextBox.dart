import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
    this.focusNode,
    this.onComplete,
    this.multiLine,
  });
  final String hintText;
  final IconData? icon;
  final FocusNode? focusNode;
  final VoidCallback? onComplete;
  final TextEditingController? controller;
  final bool? multiLine;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: onComplete,
      focusNode: focusNode,
      maxLines: (multiLine == true) ? 10 : 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        enabledBorder: const OutlineInputBorder(),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        hintText: hintText,
        alignLabelWithHint: true,
        prefixIcon: icon != null ? Icon(icon) : null,
        labelText: hintText,
      ),
    );
  }
}
