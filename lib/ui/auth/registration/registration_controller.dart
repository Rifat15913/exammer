import 'package:exammer/constants.dart';
import 'package:exammer/util/helper/keyboard.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late DatabaseReference _userPreferencesRef;

  late int selectedType;
  late bool isPasswordVisible, isConfirmPasswordVisible, isLoading;

  @override
  void onInit() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;

    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    selectedType = userTypeStudent;

    if (kDebugMode) {
      emailAddressController.text = "mohd.asfaqeazam@gmail.com";
      passwordController.text = "Storm159";
      confirmPasswordController.text = "Storm159";
    }

    FirebaseDatabase.instance.setPersistenceEnabled(true);

    _userPreferencesRef =
        FirebaseDatabase.instance.reference().child(keyUserPreferences);

    _userPreferencesRef.keepSynced(true);

    isLoading = false;
    super.onInit();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailAddressController.dispose();

    super.dispose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update(["text_form_field_password"]);
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    update(["text_form_field_confirm_password"]);
  }

  void toggleType(int type) {
    selectedType = type;
    update(["user_type"]);
  }

  bool _validateData() {
    if (Get.context != null) {
      KeyboardUtil.hideKeyboard(Get.context!);
    }

    if (!TextUtil.isNotEmpty(emailAddressController.text) ||
        !TextUtil.isNotEmpty(passwordController.text) ||
        !TextUtil.isNotEmpty(confirmPasswordController.text)) {
      ToastUtil.show('fill_up_all_fields'.tr);
      return false;
    } else if (!(RegExp(regularExpressionEmail).hasMatch(
      emailAddressController.text.trim(),
    ))) {
      ToastUtil.show('valid_email_required'.tr);
      return false;
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ToastUtil.show('passwords_do_not_match'.tr);
      return false;
    } else if (passwordController.text.trim().length < minimumPasswordLength) {
      ToastUtil.show('minimum_password_length_required'.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<void> register() async {
    if (_validateData()) {
      isLoading = true;
      update(["body"]);

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddressController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (userCredential.user != null) {
          final user = userCredential.user;

          await _userPreferencesRef.child(user!.uid).set(
            <String, int>{
              keyUserType: selectedType,
            },
          );

          if (!(user.emailVerified)) {
            await user.sendEmailVerification();
            ToastUtil.show('registration_verification'.tr);
          } else {
            ToastUtil.show('registration_successful'.tr);
          }

          isLoading = false;
          update(["body"]);
          Get.back();
        } else {
          isLoading = false;
          update(["body"]);
          ToastUtil.show('registration_error'.tr);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == authErrorTypeWeakPassword) {
          ToastUtil.show('weak_password'.tr);
        } else if (e.code == authErrorTypeDuplicateEmail) {
          ToastUtil.show('duplicate_email'.tr);
        }

        isLoading = false;
        update(["body"]);
      } catch (e) {
        print(e);

        if (TextUtil.isNotEmpty(e.toString())) {
          ToastUtil.show(e.toString().trim());
        } else {
          ToastUtil.show('registration_error'.tr);
        }

        isLoading = false;
        update(["body"]);
      }
    }
  }
}
