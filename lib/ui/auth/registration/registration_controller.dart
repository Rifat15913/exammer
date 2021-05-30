import 'package:exammer/base/exception/app_exception.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/repository/remote_repository.dart';
import 'package:exammer/ui/auth/verify/verify.dart';
import 'package:exammer/util/helper/keyboard.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailPhoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late bool isPasswordVisible, isConfirmPasswordVisible, isLoading;

  @override
  void onInit() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;

    emailPhoneController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();

    isLoading = false;
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailPhoneController.dispose();

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

  bool _validateData() {
    if (Get.context != null) {
      KeyboardUtil.hideKeyboard(Get.context!);
    }

    if (!TextUtil.isNotEmpty(emailPhoneController.text) ||
        !TextUtil.isNotEmpty(passwordController.text) ||
        !TextUtil.isNotEmpty(confirmPasswordController.text)) {
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
        final response = await RemoteRepository.on().register(
          emailPhone: emailPhoneController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (response.isSuccessful) {
          emailPhoneController.clear();
          passwordController.clear();

          Get.to(
            () => VerificationPage(
              emailPhone: emailPhoneController.text.trim(),
            ),
          );
        } else {
          if (TextUtil.isNotEmpty(response.message)) {
            ToastUtil.show(response.message);
          } else {
            ToastUtil.show('registration_error'.tr);
          }
        }

        isLoading = false;
        update(["body"]);
      } catch (e) {
        if (e is AppException) {
          ToastUtil.show(e.toString());
        } else {
          ToastUtil.show('registration_error'.tr);
        }

        isLoading = false;
        update(["body"]);
      }
    }
  }
}
