import 'package:flutter/material.dart';

class PrimaryButtonLoading extends StatelessWidget {
  final double? borderRadius;
  const PrimaryButtonLoading(
      {super.key, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10))),
        onPressed: (){},
        child: const Center(child: CircularProgressIndicator(color: Colors.white,),));
  }
}