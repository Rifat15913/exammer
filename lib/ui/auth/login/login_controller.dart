import 'package:exammer/constants.dart';
import 'package:exammer/util/helper/keyboard.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;
  late DatabaseReference _userPreferencesRef;

  late bool isLoading;
  late bool isPasswordVisible;

  @override
  void onInit() {
    super.onInit();
    isPasswordVisible = false;

    emailAddressController = TextEditingController();
    passwordController = TextEditingController();

    if (kDebugMode) {
      emailAddressController.text = "mohd.asfaqeazam@gmail.com";
      passwordController.text = "Storm159";
    }

    _userPreferencesRef =
        FirebaseDatabase.instance.reference().child(keyUserPreferences);

    isLoading = false;
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailAddressController.dispose();
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

    if (!TextUtil.isNotEmpty(emailAddressController.text) ||
        !TextUtil.isNotEmpty(passwordController.text)) {
      ToastUtil.show('fill_up_all_fields'.tr);
      return false;
    } else if (!(RegExp(regularExpressionEmail).hasMatch(
      emailAddressController.text.trim(),
    ))) {
      ToastUtil.show('valid_email_required'.tr);
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
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddressController.text.trim(),
          password: passwordController.text.trim(),
        );

        isLoading = false;
        update(["body"]);

        if (credential.user != null) {
          // TODO: Visit homepage according to user type
          _userPreferencesRef
              .child(credential.user!.uid)
              .child(keyUserType)
              .once()
              .then(
            (DataSnapshot snapshot) {
              if (snapshot.value != null) {
                if ((snapshot.value as int) == userTypeStudent) {
                  ToastUtil.show("Student");
                } else {
                  ToastUtil.show("Teacher");
                }
              } else {
                ToastUtil.show('login_error'.tr);
              }
            },
          );
        } else {
          ToastUtil.show('login_error'.tr);
        }
      } catch (e) {
        isLoading = false;
        update(["body"]);

        ToastUtil.show('login_error'.tr);
      }
    }
  }
}
