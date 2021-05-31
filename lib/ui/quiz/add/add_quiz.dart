import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/quiz/add/add_quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AddQuizController>(
          id: "body",
          init: AddQuizController(),
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
                              "Create an exam",
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
                            controller: viewController.nameController,
                            hint: "Name of the exam",
                            inputType: TextInputType.text,
                          ),
                          buildTextFormField(
                            controller: viewController.totalTimeController,
                            hint: "Total exam time in seconds",
                            inputType: TextInputType.numberWithOptions(),
                          ),
                          buildTextFormField(
                            controller: viewController.totalQuestionController,
                            hint: "Total questions",
                            inputType: TextInputType.numberWithOptions(),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          buildFilledButton(
                            onPressCallback: () {
                              viewController.addQuiz();
                            },
                            backgroundColor: colorPrimary,
                            title: "Create",
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
