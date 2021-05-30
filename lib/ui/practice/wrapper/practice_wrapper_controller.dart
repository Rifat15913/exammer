import 'package:get/get.dart';

class PracticeWrapperController extends GetxController {
  late bool isLoading;
  late String selectedProgressTime;
  late String selectedImprovementTime;

  @override
  void onInit() {
    isLoading = false;
    selectedProgressTime = "This Month";
    selectedImprovementTime = "This Month";

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeProgressTime(String newTime) {
    selectedProgressTime = newTime;
    update([]);
  }

  void changeImprovementTime(String newTime) {
    selectedImprovementTime = newTime;
    update([]);
  }
}
