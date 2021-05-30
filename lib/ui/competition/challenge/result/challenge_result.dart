import 'package:exammer/base/helper/dash_vertical_painter.dart';
import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/challenge/result/challenge_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ChallengeResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Challenge Mode",
            style: textStyleAppBar,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          leadingWidth: 64,
          brightness: Brightness.light,
          leading: IconButton(
            icon: buildBackButton(null),
            onPressed: () => Get.back(result: true),
          ).marginOnly(left: 8.0),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: GetBuilder<ChallengeResultController>(
          init: ChallengeResultController(),
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
        color: colorWinningTeamBackground,
        borderRadius: const BorderRadius.all(
          const Radius.circular(20.0),
        ),
      ),
      width: double.infinity,
      child: Text(
        "Team A Won",
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
          SizedBox(
            width: double.infinity,
            height: 100.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlayerAvatarWidget(name: "User 1", imageURL: dummyAvatar),
                PlayerAvatarWidget(name: "User 2", imageURL: dummyAvatar),
                CustomPaint(
                  size: Size(1, double.infinity),
                  painter: DashVerticalPainter(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ).marginSymmetric(horizontal: 8.0),
                PlayerAvatarWidget(name: "User 3", imageURL: dummyAvatar),
                PlayerAvatarWidget(name: "User 4", imageURL: dummyAvatar),
              ],
            ),
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
                  title: "Win",
                  total: 40,
                  teamLeftRate: 20,
                  teamRightRate: 15,
                  progressColor: colorWinProgress,
                  bottomMargin: 24.0,
                ),
                TopicStatistics(
                  title: "Lose",
                  total: 40,
                  teamLeftRate: 10,
                  teamRightRate: 10,
                  progressColor: colorLoseProgress,
                  bottomMargin: 24.0,
                ),
                TopicStatistics(
                  title: "Tie",
                  total: 40,
                  teamLeftRate: 3,
                  teamRightRate: 2,
                  progressColor: colorTieProgress,
                  bottomMargin: 24.0,
                ),
                TopicStatistics(
                  title: "Skip",
                  total: 40,
                  teamLeftRate: 7,
                  teamRightRate: 13,
                  progressColor: colorSkipProgress,
                  bottomMargin: 16.0,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 80.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Winner\n20/40",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CustomPaint(
                  size: Size(1, double.infinity),
                  painter: DashVerticalPainter(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ).marginSymmetric(horizontal: 8.0),
                Expanded(
                  child: Text(
                    "Sorry\n15/40",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
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
        onPressCallback: () {},
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
  final int teamLeftRate;
  final int teamRightRate;
  final Color progressColor;
  final double bottomMargin;

  const TopicStatistics({
    required this.title,
    required this.total,
    required this.teamLeftRate,
    required this.teamRightRate,
    required this.progressColor,
    this.bottomMargin = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "$teamLeftRate",
                style: textStyleAppBar,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).marginOnly(bottom: 8.0, left: 6.0),
              LinearPercentIndicator(
                backgroundColor: Colors.white,
                progressColor: progressColor,
                percent: (teamLeftRate / total),
                isRTL: true,
                lineHeight: 8.0,
              ).marginOnly(bottom: 6.0),
            ],
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            title,
            style: textStyleSectionTitle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "$teamRightRate",
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

class PlayerAvatarWidget extends StatelessWidget {
  final String imageURL;
  final String name;
  final int extraPaddingFromScreenWall = 96;
  final int maxPersonCount = 4;

  const PlayerAvatarWidget({
    Key? key,
    required this.name,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            backgroundImage: NetworkImage(this.imageURL),
          ).marginOnly(bottom: 8.0),
          Text(
            this.name,
            style: textStyleCaption1.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
