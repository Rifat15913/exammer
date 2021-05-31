import 'dart:convert';

import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/model/quiz/question/question.dart';
import 'package:exammer/ui/quiz/put_question/put_question.dart';
import 'package:exammer/util/helper/keyboard.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../util/lib/toast.dart';

class PutQuestionController extends GetxController {
  late TextEditingController questionController;
  late TextEditingController answerOneController;
  late TextEditingController answerTwoController;
  late TextEditingController answerThreeController;
  late TextEditingController answerFourController;
  late TextEditingController rightAnswerIndexController;
  late DatabaseReference _examRef;

  late bool isLoading;

  @override
  void onInit() {
    questionController = TextEditingController();
    answerOneController = TextEditingController();
    answerTwoController = TextEditingController();
    answerThreeController = TextEditingController();
    answerFourController = TextEditingController();
    rightAnswerIndexController = TextEditingController();

    if (kDebugMode) {
      questionController.text = "This is a demo question";
      answerOneController.text = "Answer One";
      answerTwoController.text = "Answer Two";
      answerThreeController.text = "Answer Three";
      answerFourController.text = "Answer Four";
      rightAnswerIndexController.text = "0";
    }

    FirebaseDatabase.instance.setPersistenceEnabled(true);

    _examRef = FirebaseDatabase.instance.reference().child(keyExam);

    _examRef.keepSynced(true);

    isLoading = false;
    super.onInit();
  }

  @override
  void dispose() {
    answerOneController.dispose();
    answerTwoController.dispose();
    answerThreeController.dispose();
    answerFourController.dispose();
    rightAnswerIndexController.dispose();
    questionController.dispose();

    super.dispose();
  }

  bool _validateData() {
    if (Get.context != null) {
      KeyboardUtil.hideKeyboard(Get.context!);
    }

    if (!TextUtil.isNotEmpty(questionController.text) ||
        !TextUtil.isNotEmpty(answerOneController.text) ||
        !TextUtil.isNotEmpty(answerTwoController.text) ||
        !TextUtil.isNotEmpty(answerThreeController.text) ||
        !TextUtil.isNotEmpty(answerFourController.text) ||
        !TextUtil.isNotEmpty(rightAnswerIndexController.text)) {
      ToastUtil.show('fill_up_all_fields'.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<void> addQuiz(
    bool shouldGoNext,
    String nameOfTheQuiz,
    int totalTime,
    int totalQuestionAmount,
    int nextPosition,
    List<Question> questionList,
  ) async {
    if (_validateData()) {
      if (shouldGoNext) {
        questionList.add(
          Question(
              question: questionController.text.trim(),
              answers: [
                answerOneController.text.trim(),
                answerTwoController.text.trim(),
                answerThreeController.text.trim(),
                answerFourController.text.trim(),
              ],
              rightAnswerIndex:
                  int.tryParse(rightAnswerIndexController.text.trim())!),
        );

        print(json.encode(questionList));

        Get.off(
          () => PutQuestionPage(
            nameOfTheQuiz: nameOfTheQuiz,
            totalTimeInSeconds: totalTime,
            totalQuestionAmount: totalQuestionAmount,
            positionOfCurrentQuestion: nextPosition,
            questionList: questionList,
          ),
          preventDuplicates: false,
        );
      } else {
        questionList.add(
          Question(
              question: questionController.text.trim(),
              answers: [
                answerOneController.text.trim(),
                answerTwoController.text.trim(),
                answerThreeController.text.trim(),
                answerFourController.text.trim(),
              ],
              rightAnswerIndex:
                  int.tryParse(rightAnswerIndexController.text.trim())!),
        );

        final key = _examRef.push().key;

        await _examRef.child(key).set(
          <String, dynamic>{
            "name": nameOfTheQuiz,
            "total_time": totalTime,
            "total_questions": totalQuestionAmount,
            "questions": json.encode(questionList),
          },
        );

        ToastUtil.show("The exam has been added");

        int count = 0;
        Get.until(
          (route) {
            count++;
            return count == 3;
          },
        );
      }
    }
  }
}
