import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobController extends GetxController {
  late bool isLoading, isPartTime;
  late String selectedCategory, selectedExperience;
  late TextEditingController locationController;
  late int selectedPeriod;

  @override
  void onInit() {
    isLoading = false;
    isPartTime = false;
    selectedCategory = "Category 1";
    selectedExperience = "Experience 1";
    selectedPeriod = -1;
    locationController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  void toggleJobType() {
    isPartTime = !isPartTime;
    update(["job_section"]);
  }

  void changeCategory(String newItem) {
    selectedCategory = newItem;
    update([]);
  }

  void changeExperience(String newItem) {
    selectedExperience = newItem;
    update([]);
  }

  void toggleFilterPeriod(int period) {
    selectedPeriod = period;
    update(["dialog_filter"]);
  }
}
