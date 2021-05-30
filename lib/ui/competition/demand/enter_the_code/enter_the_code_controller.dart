import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterTheCodeController extends GetxController {
  late bool isLoading;
  late TextEditingController codeController;

  @override
  void onInit() {
    isLoading = false;
    codeController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    codeController.dispose();

    super.dispose();
  }
}
