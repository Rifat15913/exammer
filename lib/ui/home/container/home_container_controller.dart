import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/category/competition_category.dart';
import 'package:exammer/ui/courses/portal/course_portal.dart';
import 'package:exammer/ui/home/content/home_content.dart';
import 'package:exammer/ui/job/view/job.dart';
import 'package:exammer/ui/practice/wrapper/practice_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContainerController extends GetxController {
  late Widget body;
  late int selectedBottomBarIndex;
  late bool isBengaliSelected;
  late String appBarTitle;

  @override
  void onInit() {
    body = HomeContentPage();
    selectedBottomBarIndex = 0;
    appBarTitle = defaultString;
    isBengaliSelected = false;

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
        appBarTitle = defaultString;
        body = HomeContentPage();
        break;
      case 1:
        appBarTitle = "Practice";
        body = PracticeWrapperPage();
        break;
      case 2:
        appBarTitle = "Competition";
        body = CompetitionCategoryPage();
        break;
      case 3:
        appBarTitle = "Courses";
        body = CoursePortalPage();
        break;
      case 4:
        appBarTitle = "Jobs";
        body = JobPage();
        break;

      default:
        appBarTitle = defaultString;
        body = HomeContentPage();
        break;
    }

    update(['bottom_bar', 'body', 'text_app_bar_title']);
  }

  void changeLanguage(bool isSelected) {
    isBengaliSelected = isSelected;
    update(['switch_language']);
  }
}
