import 'package:exammer/ui/quiz/put_question/put_question.dart';
import 'package:exammer/util/helper/keyboard.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQuizController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController totalTimeController;
  late TextEditingController totalQuestionController;

  late bool isLoading;

  @override
  void onInit() {
    nameController = TextEditingController();
    totalTimeController = TextEditingController();
    totalQuestionController = TextEditingController();

    if (kDebugMode) {
      nameController.text = "Demo Quiz";
      totalTimeController.text = "600";
      totalQuestionController.text = "5";
    }

    isLoading = false;
    super.onInit();
  }

  @override
  void dispose() {
    totalTimeController.dispose();
    totalQuestionController.dispose();
    nameController.dispose();

    super.dispose();
  }

  bool _validateData() {
    if (Get.context != null) {
      KeyboardUtil.hideKeyboard(Get.context!);
    }

    if (!TextUtil.isNotEmpty(nameController.text) ||
        !TextUtil.isNotEmpty(totalTimeController.text) ||
        !TextUtil.isNotEmpty(totalQuestionController.text)) {
      ToastUtil.show('fill_up_all_fields'.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<void> addQuiz() async {
    if (_validateData()) {
      Get.to(
        () => PutQuestionPage(
          nameOfTheQuiz: nameController.text.trim(),
          totalTimeInSeconds: int.tryParse(totalTimeController.text.trim())!,
          totalQuestionAmount:
              int.tryParse(totalQuestionController.text.trim())!,
          positionOfCurrentQuestion: 0,
          questionList: [],
        ),
      );
    }
  }
}
