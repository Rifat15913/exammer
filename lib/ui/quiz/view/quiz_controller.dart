import 'dart:async';
import 'dart:collection';

import 'package:exammer/data/remote/model/quiz/quiz.dart';
import 'package:exammer/ui/quiz/result/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  final Quiz quiz;

  QuizController({required this.quiz});

  late bool isLoading;
  late ScrollController scrollController;
  late int currentQuestionIndex;
  int? selectedIndex;
  late HashMap<int, int> givenAnswers;

  late Timer _timer;
  late int _totalTime;
  late int _leftoverTime;
  late String timeToShow;

  late DatabaseReference _resultRef;

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      _onTick,
    );
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _onTick(Timer timer) {
    if (_leftoverTime == 0) {
      timer.cancel();
      finishExam();
    } else {
      _leftoverTime--;
      timeToShow =
          "${"${(_leftoverTime ~/ 60).toString().padLeft(2, "0")}:" + "${(_leftoverTime % 60).toString().padLeft(2, "0")}"}";
      update(["exam_time"]);
    }
  }

  @override
  void onInit() {
    isLoading = false;
    scrollController = ScrollController();
    currentQuestionIndex = 0;
    givenAnswers = HashMap<int, int>();

    _totalTime = quiz.totalTime;
    _leftoverTime = quiz.totalTime;
    timeToShow =
        "${"${(_leftoverTime ~/ 60).toString().padLeft(2, "0")}:" + "${(_leftoverTime % 60).toString().padLeft(2, "0")}"}";

    _startTimer();

    _resultRef = FirebaseDatabase.instance.reference().child("result");
    _resultRef.keepSynced(true);

    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _stopTimer();

    super.dispose();
  }

  void selectItem(int index) {
    selectedIndex = index;
    givenAnswers[currentQuestionIndex] = selectedIndex!;
    update(["list_view_exam_items"]);
  }

  void changeQuestionIndex(int nextQuestionIndex) {
    if (selectedIndex != null) {
      givenAnswers[currentQuestionIndex] = selectedIndex!;
    }

    currentQuestionIndex = nextQuestionIndex;

    if (givenAnswers.containsKey(currentQuestionIndex)) {
      selectedIndex = givenAnswers[currentQuestionIndex];
    } else {
      selectedIndex = null;
    }

    update(["body"]);
  }

  Future<void> finishExam() async {
    int attended = 0, rightAnswer = 0, wrongAnswer = 0, skipped = 0;
    int total = quiz.totalQuestions;

    for (int i = 0; i < total; i++) {
      final item = quiz.questionList[i];

      if (givenAnswers.containsKey(i)) {
        attended++;

        if (givenAnswers[i] == item.rightAnswerIndex) {
          rightAnswer++;
        } else {
          wrongAnswer++;
        }
      } else {
        skipped++;
      }
    }

    final key = _resultRef.push().key;
    await _resultRef.child(key).set(
      <String, dynamic>{
        "quiz_name": quiz.name,
        "user_email": FirebaseAuth.instance.currentUser!.email,
        "total": total,
        "attended": attended,
        "skipped": skipped,
        "right": rightAnswer,
        "wrong": wrongAnswer,
        "created_at": DateTime.now().millisecondsSinceEpoch,
      },
    );

    Get.off(
      () => ResultPage(
        attended: attended,
        skipped: skipped,
        total: total,
        rightAnswer: rightAnswer,
        wrongAnswer: wrongAnswer,
        quiz: quiz,
      ),
    );
  }
}
