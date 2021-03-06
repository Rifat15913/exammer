import 'package:exammer/constants.dart';
import 'package:exammer/ui/profile/view/view_profile.dart';
import 'package:exammer/ui/quiz/list/quiz_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContainerController extends GetxController {
  late Widget body;
  late int selectedBottomBarIndex;
  late String appBarTitle;

  @override
  void onInit() {
    body = QuizListPage();
    selectedBottomBarIndex = 0;
    appBarTitle = "Exam List";

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeBottomBarIndex(int index) {
    selectedBottomBarIndex = index;

    switch (index) {
      case 0:
        appBarTitle = "Exam List";
        body = QuizListPage();
        break;

      case 1:
        appBarTitle = "Profile";
        body = ViewProfilePage();
        break;

      default:
        appBarTitle = defaultString;
        body = QuizListPage();
        break;
    }

    update(['bottom_bar', 'body', 'text_app_bar_title']);
  }
}
