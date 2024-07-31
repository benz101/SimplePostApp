import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  final double? borderRadius;
  final Function()? onPressed;
  final String? text;
  const PrimaryButton(
      {super.key, this.borderRadius, this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10))),
        onPressed: onPressed,
        child: Text(text ?? ''));
  }
}
