import 'package:flutter/material.dart';

class CustomizeButton extends StatelessWidget {
  final Color? backgroundColor;
  final double? borderRadius;
  final Function()? onPressed;
  final String? text;
  final Widget? child;
  const CustomizeButton({
    super.key,
    this.backgroundColor,
    this.borderRadius,
    this.onPressed,
    this.text,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10))),
        onPressed: onPressed,
        child:child?? Text(text ?? ''));
  }
}
