import 'package:get/get.dart';
import 'package:posting_sample_app/app/binding/authentication_binding.dart';
import 'package:posting_sample_app/app/binding/detail_of_post_binding.dart';
import 'package:posting_sample_app/app/binding/list_of_post_binding.dart';
import 'package:posting_sample_app/app/binding/splashscreen_binding.dart';
import 'package:posting_sample_app/app/ui/authentication_page.dart';
import 'package:posting_sample_app/app/ui/detail_of_post_page.dart';
import 'package:posting_sample_app/app/ui/list_of_post_page.dart';
import 'package:posting_sample_app/app/ui/splashscreen_page.dart';

class AppNavigation {
  List<GetPage<dynamic>>? getPages() {
    return [
      GetPage(
          name: SplashScreenPage.routeName,
          page: () => const SplashScreenPage(),
          binding: SplashScreenBinding()),
      GetPage(
          name: AuthenticationPage.routeName,
          page: () => const AuthenticationPage(),
          binding: AuthenticationBinding()),
      GetPage(
          name: ListOfPostPage.routeName,
          page: () => const ListOfPostPage(),
          binding: ListOfPostBinding()),
      GetPage(
          name: DetailOfPostPage.routeName,
          page: () => const DetailOfPostPage(),
          binding: DetailOfPostBinding()),
    ];
  }
}
