import 'package:get/get.dart';

class ReferralInviteController extends GetxController {
  late bool isLoading;
  late String selectedTimePeriod;

  @override
  void onInit() {
    isLoading = false;
    selectedTimePeriod = "Last week";

    super.onInit();
  }

  void changeTimePeriod(String newItem) {
    selectedTimePeriod = newItem;
    update(["dropdown_button_time_period"]);
  }
}
