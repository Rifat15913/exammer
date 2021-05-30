import 'dart:collection';

import 'package:get/get.dart';

class ChallengeCompetitionController extends GetxController {
  late bool isLoading;
  late HashMap<String, int> selectedIndexMap;

  @override
  void onInit() {
    selectedIndexMap = HashMap<String, int>();
    isLoading = false;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectItemFromTopSection(int index) {
    selectedIndexMap['top'] = index;
    update(['chips_challenge_type']);
  }

  void deselectItemFromTopSection(int index) {
    selectedIndexMap.remove('top');
    update(['chips_challenge_type']);
  }

  void selectItemFromBottomSection(int index) {
    selectedIndexMap['bottom'] = index;
    update(['chips_topic']);
  }

  void deselectItemFromBottomSection(int index) {
    selectedIndexMap.remove('bottom');
    update(['chips_topic']);
  }
}
