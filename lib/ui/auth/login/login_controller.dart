import 'package:exammer/base/exception/app_exception.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/repository/remote_repository.dart';
import 'package:exammer/ui/preferences/introduction/introduction.dart';
import 'package:exammer/util/helper/keyboard.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/preference.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailPhoneController;
  late TextEditingController passwordController;
  late bool isLoading;
  late bool isPasswordVisible;

  @override
  void onInit() {
    super.onInit();
    isPasswordVisible = false;

    emailPhoneController = TextEditingController();
    passwordController = TextEditingController();

    if (kDebugMode) {
      emailPhoneController.text = "a@a.com";
      passwordController.text = "11111111";
    }

    isLoading = false;
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailPhoneController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update(["text_form_field_password"]);
  }

  bool _validateData() {
    if (Get.context != null) {
      KeyboardUtil.hideKeyboard(Get.context!);
    }

    if (!TextUtil.isNotEmpty(emailPhoneController.text) ||
        !TextUtil.isNotEmpty(passwordController.text)) {
      ToastUtil.show('fill_up_all_fields'.tr);
      return false;
    } else if (!(RegExp(regularExpressionEmail).hasMatch(
          emailPhoneController.text.trim(),
        ) ||
        RegExp(regularExpressionPhone).hasMatch(
          emailPhoneController.text.trim(),
        ))) {
      ToastUtil.show('valid_email_phone_required'.tr);
      return false;
    } else if (passwordController.text.trim().length < minimumPasswordLength) {
      ToastUtil.show('minimum_password_length_required'.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<void> login() async {
    if (_validateData()) {
      isLoading = true;
      update(["body"]);

      try {
        final response = await RemoteRepository.on().login(
          emailPhoneController.text.trim(),
          passwordController.text.trim(),
        );

        if (response.isSuccessful) {
          emailPhoneController.clear();
          passwordController.clear();

          PreferenceUtil.on.write<String>(
            keyAuthToken,
            (prefixAuthToken + response.token),
          );

          Get.offAll(() => IntroductionPage());
        } else {
          if (TextUtil.isNotEmpty(response.message)) {
            ToastUtil.show(response.message);
          } else {
            ToastUtil.show('login_error'.tr);
          }
        }

        isLoading = false;
        update(["body"]);
      } catch (e) {
        if (e is AppException) {
          ToastUtil.show(e.toString());
        } else {
          ToastUtil.show('login_error'.tr);
        }

        isLoading = false;
        update(["body"]);
      }
    }
  }
}
