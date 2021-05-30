import 'dart:collection';

import 'package:exammer/base/exception/app_exception.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/repository/remote_repository.dart';
import 'package:exammer/ui/home/container/home_container.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/preference.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:get/get.dart';

const String keyTop = "top";
const String keyMiddle = "middle";
const String keyBottom = "bottom";

class SurveyController extends GetxController {
  late bool isLoading;
  late HashMap<String, int> selectedIndexMap;
  late HashMap<int, bool> selectedTrainingIdMap;
  late HashMap<String, String> selectedData;

  @override
  void onInit() {
    selectedIndexMap = HashMap<String, int>();
    selectedTrainingIdMap = HashMap<int, bool>();
    selectedData = HashMap<String, String>();
    isLoading = false;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectItemFromTopSection(int id) {
    selectedTrainingIdMap[id] = true;
    update(['list_view_top_section']);
  }

  void deselectItemFromTopSection(int id) {
    selectedTrainingIdMap.remove(id);
    update(['list_view_top_section']);
  }

  void selectItemFromMiddleSection(int index, String item) {
    selectedIndexMap[keyMiddle] = index;
    selectedData[keyMiddle] = item;
    update(['chips_preparation_time']);
  }

  void deselectItemFromMiddleSection() {
    selectedIndexMap.remove(keyMiddle);
    selectedData.remove(keyMiddle);
    update(['chips_preparation_time']);
  }

  void selectItemFromBottomSection(int index, String item) {
    selectedIndexMap[keyBottom] = index;
    selectedData[keyBottom] = item;
    update(['chips_current_work']);
  }

  void deselectItemFromBottomSection() {
    selectedIndexMap.remove(keyBottom);
    selectedData.remove(keyBottom);
    update(['chips_current_work']);
  }

  bool _validateData() {
    if (selectedTrainingIdMap.isEmpty &&
        !selectedData.containsKey(keyMiddle) &&
        !selectedData.containsKey(keyBottom)) {
      ToastUtil.show('survey_select_all'.tr);
      return false;
    } else if (selectedTrainingIdMap.isEmpty) {
      ToastUtil.show('survey_select_category'.tr);
      return false;
    } else if (!selectedData.containsKey(keyMiddle)) {
      ToastUtil.show('survey_select_time'.tr);
      return false;
    } else if (!selectedData.containsKey(keyBottom)) {
      ToastUtil.show('survey_select_profession'.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<void> finishSurvey() async {
    if (_validateData()) {
      isLoading = true;
      update(["body"]);

      try {
        final trainingCategoryList = <int>[];
        trainingCategoryList.clear();

        selectedTrainingIdMap.keys.forEach(
          (element) {
            trainingCategoryList.add(element);
          },
        );

        final response = await RemoteRepository.on().submitSurveyData(
          categoryList: trainingCategoryList,
          timeLength: selectedData[keyMiddle]!,
          profession: selectedData[keyBottom]!,
        );

        if (response.isSuccessful) {
          if (TextUtil.isNotEmpty(response.message)) {
            ToastUtil.show(response.message);
          }

          await PreferenceUtil.on.write<bool>(
            keySubmittedPreferences,
            true,
          );

          Get.offAll(() => HomeContainerPage());
        } else {
          if (TextUtil.isNotEmpty(response.message)) {
            ToastUtil.show(response.message);
          } else {
            ToastUtil.show('survey_failed_to_submit'.tr);
          }
        }

        isLoading = false;
        update(["body"]);
      } catch (e) {
        if (e is AppException) {
          ToastUtil.show(e.toString());
        } else {
          ToastUtil.show('survey_failed_to_submit'.tr);
        }

        isLoading = false;
        update(["body"]);
      }
    }
  }
}
