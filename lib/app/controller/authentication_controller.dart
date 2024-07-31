import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:posting_sample_app/app/helper/request_state.dart';
import 'package:posting_sample_app/app/helper/user_session_storage.dart';
import 'package:posting_sample_app/app/model/user_session.dart';
import 'package:posting_sample_app/app/ui/list_of_post_page.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController emailCtrl = TextEditingController(text: '');
  final TextEditingController passwordCtrl = TextEditingController(text: '');
  RequestState state = RequestState.IS_IDLE;
  bool isShowPassword = false;
  bool isRegisterMode = false;

  void login() async {
    if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      Get.snackbar('Message', 'Text input cannot be empty!');
      return;
    }
    if (passwordCtrl.text.length < 6) {
      Get.snackbar('Message', 'Password must be minimal 6 character');
      return;
    }
    state = RequestState.IS_LOADING;
    update();
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: emailCtrl.text, password: passwordCtrl.text);
      debugPrint('result signin: $result');
      if (!result.additionalUserInfo!.isNewUser) {
        state = RequestState.IS_SUCCESS;
        UserSessionStorage().setUserSession(UserSession(
            email: result.user!.email, isLogin: true, isViaGoogle: false));
        update();
        Get.offAndToNamed(ListOfPostPage.routeName);
      } else {
        Get.snackbar('Message', 'Login is failed');
        state = RequestState.IS_ERROR;
        update();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Message', 'Login is error\n$e');
      debugPrint('error signin: $e');
      state = RequestState.IS_ERROR;
      update();
    }
  }

  void register() async {
    if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      Get.snackbar('Message', 'Text input cannot be empty!');
      return;
    }
    if (passwordCtrl.text.length < 6) {
      Get.snackbar('Message', 'Password must be min 6 character');
      return;
    }
    state = RequestState.IS_LOADING;
    update();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: emailCtrl.text, password: passwordCtrl.text);
      debugPrint('result register: $result');
      if (result.additionalUserInfo!.isNewUser) {
        state = RequestState.IS_SUCCESS;
        UserSessionStorage().setUserSession(UserSession(
            email: result.user!.email, isLogin: true, isViaGoogle: false));
        state = RequestState.IS_SUCCESS;
        update();

        Get.snackbar('Message', 'Register is success');
        switchToModeRegister(false);
      } else {
        Get.snackbar('Message', 'Register is failed');
        state = RequestState.IS_ERROR;
        update();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Message', 'Register is error\n$e');
      debugPrint('error signin: $e');
      state = RequestState.IS_ERROR;
      update();
    }
  }

  Future<void> loginInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      debugPrint('accessToken: ${googleAuth?.accessToken}');
      debugPrint('idToken: ${googleAuth?.idToken}');

      // Sign in to Firebase with the Google [UserCredential]
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      debugPrint('userCredential.user: ${userCredential.user}');

      UserSessionStorage().setUserSession(UserSession(
          email: userCredential.user!.email, isLogin: true, isViaGoogle: true));
      Get.offAndToNamed(ListOfPostPage.routeName);
    } catch (e) {
      debugPrint('loginInWithGoogle error because: $e');
      Get.snackbar('Message', '$e');
    }
  }

  void switchToModeRegister(bool param) {
    isRegisterMode = param;
    emailCtrl.clear();
    passwordCtrl.clear();
    update();
  }
}
