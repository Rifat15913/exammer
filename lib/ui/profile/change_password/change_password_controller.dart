import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  late bool isLoading, isOldPasswordVisible;
  late bool isNewPasswordVisible, isConfirmNewPasswordVisible;
  late TextEditingController oldPasswordController, newPasswordController;
  late TextEditingController confirmNewPasswordController;

  @override
  void onInit() {
    isLoading = false;
    isOldPasswordVisible = false;
    isNewPasswordVisible = false;
    isConfirmNewPasswordVisible = false;

    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();

    super.dispose();
  }

  void toggleOldPasswordVisibility() {
    isOldPasswordVisible = !isOldPasswordVisible;
    update(["text_form_field_old_password"]);
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible = !isNewPasswordVisible;
    update(["text_form_field_new_password"]);
  }

  void toggleConfirmNewPasswordVisibility() {
    isConfirmNewPasswordVisible = !isConfirmNewPasswordVisible;
    update(["text_form_field_confirm_new_password"]);
  }
}
