import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/model/quiz/question/question.dart';
import 'package:exammer/ui/quiz/put_question/put_question_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PutQuestionPage extends StatelessWidget {
  final String nameOfTheQuiz;
  final int totalTimeInSeconds, totalQuestionAmount;
  final int positionOfCurrentQuestion;
  final List<Question> questionList;

  PutQuestionPage({
    required this.nameOfTheQuiz,
    required this.totalTimeInSeconds,
    required this.totalQuestionAmount,
    required this.positionOfCurrentQuestion,
    required this.questionList,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<PutQuestionController>(
          id: "body",
          init: PutQuestionController(),
          builder: (viewController) {
            return viewController.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: buildBackButton(
                                  () => Get.back(),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              "Create question no. ${positionOfCurrentQuestion + 1}",
                              style: textStylePageTitle,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                              bottom: 24.0,
                            ),
                            child: Text(
                              "Provide required information",
                              style: textStylePageSubtitle,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          buildTextFormField(
                            controller: viewController.questionController,
                            hint: "Question",
                            inputType: TextInputType.text,
                          ),
                          buildTextFormField(
                            controller: viewController.answerOneController,
                            hint: "Option",
                            inputType: TextInputType.text,
                          ),
                          buildTextFormField(
                            controller: viewController.answerTwoController,
                            hint: "Option",
                            inputType: TextInputType.text,
                          ),
                          buildTextFormField(
                            controller: viewController.answerThreeController,
                            hint: "Option",
                            inputType: TextInputType.text,
                          ),
                          buildTextFormField(
                            controller: viewController.answerFourController,
                            hint: "Option",
                            inputType: TextInputType.text,
                          ),
                          buildTextFormField(
                            controller:
                                viewController.rightAnswerIndexController,
                            hint: "Right answer index",
                            inputType: TextInputType.numberWithOptions(),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          buildFilledButton(
                            onPressCallback: () {
                              viewController.addQuiz(
                                (positionOfCurrentQuestion + 1 <
                                    totalQuestionAmount),
                                nameOfTheQuiz,
                                totalTimeInSeconds,
                                totalQuestionAmount,
                                positionOfCurrentQuestion + 1,
                                questionList,
                              );
                            },
                            backgroundColor: colorPrimary,
                            title: (positionOfCurrentQuestion + 1 <
                                    totalQuestionAmount)
                                ? "Next"
                                : "Finish",
                          ),
                          SizedBox(
                            height: 32.0,
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
