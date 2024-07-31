
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:posting_sample_app/app/helper/request_state.dart';
import 'package:posting_sample_app/app/helper/user_session_storage.dart';
import 'package:posting_sample_app/app/model/list_of_post.dart';
import 'package:posting_sample_app/app/model/user_session.dart';
import 'package:posting_sample_app/app/reusable_widget/customize_button.dart';
import 'package:posting_sample_app/app/reusable_widget/primary_button.dart';
import 'package:posting_sample_app/app/service/post_service.dart';
import 'package:posting_sample_app/app/ui/authentication_page.dart';

class ListOfPostController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final PostService _postService = PostService();
  RequestState state = RequestState.IS_IDLE;
  List<ItemOfPost> listOfData = [];
  List<ItemOfPost> listOfDataTemp = [];

  TextEditingController keywordCtrl = TextEditingController(text: '');

  @override
  void onInit() async {
    getListOfPostProcess();
    keywordCtrl.addListener(() {
      searchingItem(keywordCtrl.text);
    });
    super.onInit();
  }

  @override
  void onClose() {
    keywordCtrl.dispose();
  }

  Future<void> getListOfPostProcess() async {
    keywordCtrl.clear();
    state = RequestState.IS_LOADING;
    update();
    final result = await _postService.getListOfPost();
    if (result.isSuccess) {
      state = RequestState.IS_SUCCESS;
      listOfData = result.data ?? [];
      listOfDataTemp = result.data ?? [];
      update();
    } else {
      state = RequestState.IS_ERROR;
      update();
    }
  }

  Future<void> searchingItem(String keyword) async {
    state = RequestState.IS_LOADING;
    update();
    List<ItemOfPost>? result;
    await Future.delayed(const Duration(seconds: 2));

    if (RegExp(r'^\d+$').hasMatch(keyword)) {
      result = await getDetailOfPostProcess(int.parse(keyword));
    } else {
      result = listOfDataTemp
          .where((e) =>
              (e.title ?? '').toLowerCase().contains(keyword.toLowerCase()) ||
              (e.body ?? '').toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    state = RequestState.IS_SUCCESS;
    listOfData = result;
    update();
  }

  Future<List<ItemOfPost>> getDetailOfPostProcess(int param) async {
    debugPrint('getDetailOfPostProcess of listOfPost');
    final result = await _postService.getDetailOfPost(id: param);
    if (result.isSuccess) {
      final itemResult = result.data!;
      return [
        ...[itemResult]
      ];
    } else {
      return [];
    }
  }

  Future<void> logoutApp() async {
    debugPrint('logoutApp');
    try {
      await auth.signOut();
      UserSessionStorage().setUserSession(UserSession(
          email: UserSessionStorage().getUserSession!.email,
          isLogin: false,
          isViaGoogle: false));
      Get.offAllNamed(AuthenticationPage.routeName);
    } catch (e) {
      Get.snackbar('Message', '$e');
    }
  }

  Future<void> logOutAppViaGoogle() async {
    debugPrint('logOutAppViaGoogle');
    try {
      await _googleSignIn.signOut();
      UserSessionStorage().setUserSession(UserSession(
          email: UserSessionStorage().getUserSession!.email,
          isLogin: false,
          isViaGoogle: true));
      Get.offAllNamed(AuthenticationPage.routeName);
    } catch (e) {
      Get.snackbar('Message', '$e');
    }
  }

  Future<void> showLogoutAppBottomSheet(BuildContext context) async {
    Get.bottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      color: Colors.transparent,
                      child: Container(
                          color: Colors.transparent,
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                              'Are You sure to logout this app ?')))),
              Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            height: 45,
                            color: Colors.transparent,
                            child: Container(
                                color: Colors.transparent,
                                child: CustomizeButton(
                                  backgroundColor: Colors.red,
                                  onPressed: () {
                                    debugPrint('Yes for logout app');
                                    Get.back();
                                    if (UserSessionStorage()
                                            .getUserSession
                                            ?.isViaGoogle ??
                                        false) {
                                      logOutAppViaGoogle();
                                    } else {
                                      logoutApp();
                                    }
                                  },
                                  text: 'Yes',
                                ))),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            height: 45,
                            color: Colors.transparent,
                            child: Container(
                                color: Colors.transparent,
                                child: PrimaryButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  text: 'No',
                                ))),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
