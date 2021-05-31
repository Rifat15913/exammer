import 'dart:async';

import 'package:exammer/constants.dart';
import 'package:exammer/ui/auth/login/login.dart';
import 'package:exammer/ui/home/container/home_container.dart';
import 'package:exammer/util/lib/preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void goToNextPage() {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null &&
        PreferenceUtil.on.read<int>(keyUserType, defaultValue: -1) != -1;

    if (isLoggedIn) {
      Get.offAll(
        () => HomeContainerPage(
          userType: PreferenceUtil.on.read<int>(keyUserType)!,
        ),
      );
    } else {
      Get.offAll(() => LoginPage());
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
