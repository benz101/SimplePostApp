import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posting_sample_app/app/controller/splashscreen_controller.dart';

class SplashScreenPage extends StatelessWidget {
  static const routeName = '/splash-screen-page';
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SplashScreenController(),
        builder: (controller) {
          return Scaffold(
              body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    controller.welcomeText,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  )));
        });
  }
}
