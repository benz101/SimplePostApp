import 'package:get/get.dart';
import 'package:posting_sample_app/app/controller/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
  }
  
}