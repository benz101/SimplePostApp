import 'package:get/get.dart';
import 'package:posting_sample_app/app/controller/list_of_post_controller.dart';

class ListOfPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListOfPostController());
  }
}