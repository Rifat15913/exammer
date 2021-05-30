import 'package:exammer/constants.dart';
import 'package:exammer/util/helper/keyboard.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  late TextEditingController emailAddressController;

  late bool isLoading;

  @override
  void onInit() {
    super.onInit();

    emailAddressController = TextEditingController();

    if (kDebugMode) {
      emailAddressController.text = "mohd.asfaqeazam@gmail.com";
    }

    isLoading = false;
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    super.dispose();
  }

  bool _validateData() {
    if (Get.context != null) {
      KeyboardUtil.hideKeyboard(Get.context!);
    }

    if (!TextUtil.isNotEmpty(emailAddressController.text)) {
      ToastUtil.show('fill_up_the_field'.tr);
      return false;
    } else if (!(RegExp(regularExpressionEmail).hasMatch(
      emailAddressController.text.trim(),
    ))) {
      ToastUtil.show('valid_email_required'.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<void> resetPassword() async {
    if (_validateData()) {
      isLoading = true;
      update(["body"]);

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailAddressController.text.trim(),
        );

        isLoading = false;
        update(["body"]);

        ToastUtil.show('reset_password_check_email'.tr);

        Get.back();
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        update(["body"]);

        if (TextUtil.isNotEmpty(e.message)) {
          ToastUtil.show(e.message!);
        }
      } catch (e) {
        isLoading = false;
        update(["body"]);

        ToastUtil.show('reset_password_failed'.tr);
      }
    }
  }
}
