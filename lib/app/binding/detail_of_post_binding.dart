import 'package:get/get.dart';
import 'package:posting_sample_app/app/controller/detail_of_post_controller.dart';

class DetailOfPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailOfPostController());
  }
}