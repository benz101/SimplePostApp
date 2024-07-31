import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posting_sample_app/app/controller/authentication_controller.dart';
import 'package:posting_sample_app/app/helper/request_state.dart';
import 'package:posting_sample_app/app/reusable_widget/customize_button.dart';
import 'package:posting_sample_app/app/reusable_widget/primary_button.dart';
import 'package:posting_sample_app/app/reusable_widget/primary_button_loading.dart';
import 'package:posting_sample_app/app/reusable_widget/primary_textfield.dart';

class AuthenticationPage extends StatelessWidget {
  static const routeName = '/authentication-page';
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AuthenticationController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (controller.isRegisterMode) {
                controller.switchToModeRegister(false);
                return false;
              } else {
                controller.switchToModeRegister(true);
                return true;
              }
            },
            child: Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    LoginLabelBuilder(controller: controller),
                    const SizedBox(height: 15),
                    LoginFormBuilder(controller: controller),
                    !controller.isRegisterMode
                        ? DontHaveAccountLabel(controller: controller)
                        : Container(
                            height: 15,
                          ),
                    !controller.isRegisterMode
                        ? LoginButtonBuilder(controller: controller)
                        : RegisterButtonBuilder(controller: controller),
                    const SizedBox(height: 15),
                    LoginButtonWithGoogleBuilder(controller: controller)
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class LoginLabelBuilder extends StatelessWidget {
  final AuthenticationController controller;

  const LoginLabelBuilder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: !controller.isRegisterMode
          ? const Text(
              'Welcome to the Login Page :)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )
          : const Text(
              'Welcome to the Register Page :)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
    );
  }
}

class LoginFormBuilder extends StatelessWidget {
  final AuthenticationController controller;
  const LoginFormBuilder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.transparent,
              child: PrimaryTextField(
                controller: controller.emailCtrl,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              color: Colors.transparent,
              child: PrimaryTextField(
                controller: controller.passwordCtrl,
                hintText: 'Password',
                obsecureText: controller.isShowPassword ? false : true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButtonBuilder extends StatelessWidget {
  final AuthenticationController controller;
  const LoginButtonBuilder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
          width: double.infinity,
          height: 45,
          color: Colors.transparent,
          child: controller.state != RequestState.IS_LOADING
              ? PrimaryButton(
                  onPressed: () => controller.login(),
                  text: 'LOGIN',
                )
              : const PrimaryButtonLoading()),
    );
  }
}

class RegisterButtonBuilder extends StatelessWidget {
  final AuthenticationController controller;
  const RegisterButtonBuilder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
          width: double.infinity,
          height: 45,
          color: Colors.transparent,
          child: controller.state != RequestState.IS_LOADING
              ? PrimaryButton(
                  onPressed: () => controller.register(),
                  text: 'REGISTER',
                )
              : const PrimaryButtonLoading()),
    );
  }
}

class LoginButtonWithGoogleBuilder extends StatelessWidget {
  final AuthenticationController controller;
  const LoginButtonWithGoogleBuilder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
          width: double.infinity,
          height: 45,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: CustomizeButton(
            onPressed: () => controller.loginInWithGoogle(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/img_logo_google.png',
                    width: 25, height: 25),
                const SizedBox(width: 10),
                const Text('LOGIN WITH GOOGLE')
              ],
            ),
          )),
    );
  }
}

class DontHaveAccountLabel extends StatelessWidget {
  final AuthenticationController controller;
  const DontHaveAccountLabel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
          width: double.infinity,
          height: 45,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text('Not have account ?',
                  style: TextStyle(decoration: TextDecoration.underline)),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                  onTap: () => controller.switchToModeRegister(true),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          )),
    );
  }
}
