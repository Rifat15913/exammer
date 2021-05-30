import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqsController extends GetxController {
  late bool isLoading;
  late ScrollController scrollController;

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
}
