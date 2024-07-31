import 'package:get/get.dart';
import 'package:posting_sample_app/app/controller/splashscreen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}