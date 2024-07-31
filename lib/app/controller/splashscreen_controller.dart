import 'package:get/get.dart';
import 'package:posting_sample_app/app/helper/user_session_storage.dart';
import 'package:posting_sample_app/app/ui/authentication_page.dart';
import 'package:posting_sample_app/app/ui/list_of_post_page.dart';

class SplashScreenController extends GetxController {

  String welcomeText = 'Welcome in Posts App App :)';

  @override
  void onInit() {
    checkAuthorization();
    super.onInit();
  }

  Future<void> checkAuthorization() async {
    await Future.delayed(const Duration(seconds: 1));
    bool? isLogin = UserSessionStorage().getUserSession?.isLogin;
    if (isLogin ?? false) {
      Get.offNamed(ListOfPostPage.routeName);
    } else {
      Get.offNamed(AuthenticationPage.routeName);
    }
  }
}
