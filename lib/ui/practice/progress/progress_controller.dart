import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  late bool isLoading;
  late ScrollController scrollController;
  late String selectedTime;

  @override
  void onInit() {
    isLoading = false;
    scrollController = ScrollController();
    selectedTime = "This Month";

    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  void changeSubject(String newSubject) {
    selectedTime = newSubject;
  }
}
