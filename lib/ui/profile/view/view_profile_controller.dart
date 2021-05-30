import 'package:get/get.dart';

class ViewProfileController extends GetxController {
  late bool isLoading, isMonthlyScore;
  late String selectedSubject;

  @override
  void onInit() {
    isLoading = false;
    isMonthlyScore = true;
    selectedSubject = "Math";

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toggleScoreView() {
    isMonthlyScore = !isMonthlyScore;
    update(["score_view"]);
  }

  void changeSubject(String newSubject) {
    selectedSubject = newSubject;
    update(["score_view"]);
  }
}
