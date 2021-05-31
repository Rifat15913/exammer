import 'dart:async';
import 'dart:convert';

import 'package:exammer/data/remote/model/quiz/question/question.dart';
import 'package:exammer/data/remote/model/quiz/quiz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class QuizListController extends GetxController {
  late bool isLoading;
  late StreamSubscription<Event> _examSubscription;
  late DatabaseReference _examRef;
  late List<Quiz> quizList;

  @override
  void onInit() {
    isLoading = true;
    quizList = [];

    _examRef = FirebaseDatabase.instance.reference().child(keyExam);

    _examRef.keepSynced(true);

    _examSubscription = _examRef.onValue.listen((Event event) {
      quizList.clear();

      event.snapshot.value.forEach(
        (key, value) {
          final quiz = Quiz(
            name: (value as Map)["name"] as String,
            totalTime: (value)["total_time"] as int,
            totalQuestions: (value)["total_questions"] as int,
            questionList: (jsonDecode(value["questions"]) as List<dynamic>)
                .map(
                  (e) => Question(
                    question: (e as Map<String, dynamic>)["question"] as String,
                    rightAnswerIndex: e["right_answer_index"] as int,
                    answers: (e["answers"] as List<dynamic>)
                        .map((e) => e as String)
                        .toList(),
                  ),
                )
                .toList(),
          );
          quizList.add(quiz);
        },
      );

      isLoading = false;
      update(["body"]);
    }, onError: (Object o) {
      final DatabaseError error = o as DatabaseError;
      print('Error: ${error.code} ${error.message}');

      isLoading = false;
      update(["body"]);
    });

    super.onInit();
  }

  @override
  void dispose() {
    _examSubscription.cancel();
    super.dispose();
  }
}
