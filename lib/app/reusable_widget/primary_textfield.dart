import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final bool? obsecureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  const PrimaryTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.obsecureText,
      this.keyboardType,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obsecureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
          hintText: hintText, border: const OutlineInputBorder(), prefixIcon: prefixIcon),
    );
  }
}
