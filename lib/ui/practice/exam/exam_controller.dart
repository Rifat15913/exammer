import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamController extends GetxController {
  late bool isLoading;
  late ScrollController scrollController;
  int? selectedIndex;

  @override
  void onInit() {
    isLoading = false;
    scrollController = ScrollController();

    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  void selectItem(int index) {
    selectedIndex = index;
    update(["list_view_exam_items"]);
  }
}
