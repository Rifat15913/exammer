import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  late bool isLoading;
  late TextEditingController nameController, emailController, phoneController;

  @override
  void onInit() {
    isLoading = false;
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }
}
