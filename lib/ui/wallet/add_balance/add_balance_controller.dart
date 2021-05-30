import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBalanceController extends GetxController {
  late bool isLoading;
  late TextEditingController cardNumberController, expiredTimeController;
  late TextEditingController cvvController;
  late HashMap<String, int> selectedIndexMap;

  @override
  void onInit() {
    isLoading = false;

    cardNumberController = TextEditingController();
    expiredTimeController = TextEditingController();
    cvvController = TextEditingController();

    selectedIndexMap = HashMap<String, int>();

    super.onInit();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiredTimeController.dispose();
    cvvController.dispose();

    super.dispose();
  }

  void selectItemFromPaymentMethods(int index) {
    selectedIndexMap['top'] = index;
    update(['list_view_payment_method_section']);
  }
}
