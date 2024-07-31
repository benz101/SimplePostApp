import 'package:get/get.dart';
import 'package:posting_sample_app/app/helper/request_state.dart';
import 'package:posting_sample_app/app/model/list_of_post.dart';
import 'package:posting_sample_app/app/service/post_service.dart';

class DetailOfPostController extends GetxController {
  int? id;
  final PostService _postService = PostService();
  RequestState state = RequestState.IS_IDLE;
  ItemOfPost? detailOfData;

  @override
  void onInit() async {
    id = Get.arguments['postId'];
    getDetailOfPostProcess();

    super.onInit();
  }

  Future<void> getDetailOfPostProcess() async {
    state = RequestState.IS_LOADING;
    update();
    final result = await _postService.getDetailOfPost(id: id!);
    if (result.isSuccess) {
      state = RequestState.IS_SUCCESS;
      detailOfData = result.data;
      update();
    } else {
      state = RequestState.IS_ERROR;
      update();
    }
  }
}
