import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/model/quiz/quiz.dart';
import 'package:exammer/ui/quiz/result/result_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ResultPage extends StatelessWidget {
  final int attended, rightAnswer, wrongAnswer, skipped;
  final int total;
  final Quiz quiz;

  ResultPage({
    required this.attended,
    required this.skipped,
    required this.total,
    required this.rightAnswer,
    required this.wrongAnswer,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Result",
            style: textStyleAppBar,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          leadingWidth: 64,
          brightness: Brightness.light,
          leading: IconButton(
            icon: buildCloseButton(null),
            onPressed: () => Get.back(result: true),
          ).marginOnly(left: 8.0),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: GetBuilder<ResultController>(
          init: ResultController(),
          builder: (controller) {
            return controller.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildContainerTopHood(),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildGameInformationWidget(),
                                buildPlayerInformationWidget(),
                              ],
                            ),
                          ),
                        ),
                        buildBottomSection(),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Container buildGameInformationWidget() {
    return Container(
      margin: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      padding: const EdgeInsets.all(32.0),
      decoration: const BoxDecoration(
        color: colorAccent,
        borderRadius: const BorderRadius.all(
          const Radius.circular(20.0),
        ),
      ),
      width: double.infinity,
      child: Text(
        quiz.name,
        style: textStyleSectionTitle.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 22.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget buildPlayerInformationWidget() {
    const String dummyAvatar =
        "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg";

    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: colorAccent,
        borderRadius: const BorderRadius.all(
          const Radius.circular(20.0),
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Great Work",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: const BorderRadius.all(
                const Radius.circular(16.0),
              ),
            ),
            child: Column(
              children: [
                TopicStatistics(
                  title: "Right",
                  total: quiz.totalQuestions,
                  teamRightRate: rightAnswer,
                  progressColor: colorWinProgress,
                  bottomMargin: 24.0,
                ),
                TopicStatistics(
                  title: "Wrong",
                  total: quiz.totalQuestions,
                  teamRightRate: wrongAnswer,
                  progressColor: colorLoseProgress,
                  bottomMargin: 24.0,
                ),
                TopicStatistics(
                  title: "Attended",
                  total: quiz.totalQuestions,
                  teamRightRate: attended,
                  progressColor: colorTieProgress,
                  bottomMargin: 24.0,
                ),
                TopicStatistics(
                  title: "Skip",
                  total: quiz.totalQuestions,
                  teamRightRate: skipped,
                  progressColor: colorSkipProgress,
                  bottomMargin: 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: buildFilledButton(
        onPressCallback: () {
          Get.back(result: true);
        },
        backgroundColor: colorPrimary,
        title: "Go to Home",
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 24.0,
        ),
      ),
    );
  }
}

class TopicStatistics extends StatelessWidget {
  final String title;
  final int total;
  final int teamRightRate;
  final Color progressColor;
  final double bottomMargin;

  const TopicStatistics({
    required this.title,
    required this.total,
    required this.teamRightRate,
    required this.progressColor,
    this.bottomMargin = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            title,
            style: textStyleSectionTitle,
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "$teamRightRate / $total",
                style: textStyleAppBar,
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).marginOnly(bottom: 8.0, right: 6.0),
              LinearPercentIndicator(
                backgroundColor: Colors.white,
                progressColor: progressColor,
                percent: (teamRightRate / total),
                isRTL: false,
                lineHeight: 8.0,
              ).marginOnly(bottom: 6.0),
            ],
          ),
        ),
      ],
    ).marginOnly(bottom: this.bottomMargin);
  }
}
