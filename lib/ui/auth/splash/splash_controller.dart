import 'dart:async';

import 'package:exammer/constants.dart';
import 'package:exammer/ui/auth/login/login.dart';
import 'package:exammer/ui/home/container/home_container.dart';
import 'package:exammer/ui/preferences/introduction/introduction.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/preference.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void goToNextPage() {
    final isLoggedIn = TextUtil.isNotEmpty(
      PreferenceUtil.on.read<String?>(
        keyAuthToken,
        defaultValue: null,
      ),
    );

    if (isLoggedIn) {
      if (PreferenceUtil.on.read<bool>(
        keySubmittedPreferences,
        defaultValue: false,
      )!) {
        Get.off(() => HomeContainerPage());
      } else {
        Get.off(() => IntroductionPage());
      }
    } else {
      Get.off(() => LoginPage());
    }
  }

  @override
  void onInit() {
    Timer(
      Duration(seconds: 2),
      goToNextPage,
    );
    super.onInit();
  }
}
