import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImprovementController extends GetxController {
  late bool isLoading;
  late ScrollController scrollController, dialogCourseScrollController;
  late ScrollController dialogFeedbackScrollController;
  late String selectedTime;

  @override
  void onInit() {
    isLoading = false;
    scrollController = ScrollController();
    dialogCourseScrollController = ScrollController();
    dialogFeedbackScrollController = ScrollController();
    selectedTime = "Today";

    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    dialogCourseScrollController.dispose();
    dialogFeedbackScrollController.dispose();

    super.dispose();
  }

  void changeSubject(String newSubject) {
    selectedTime = newSubject;
  }
}
