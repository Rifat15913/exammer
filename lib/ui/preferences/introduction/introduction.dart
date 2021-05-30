import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/preferences/introduction/introduction_controller.dart';
import 'package:exammer/ui/preferences/survey/survey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GetBuilder<IntroductionController>(
                  id: "video_player",
                  init: IntroductionController(),
                  builder: (introductionController) {
                    return buildVideoPlayer(introductionController);
                  },
                ),
              ),
              GetBuilder<IntroductionController>(
                init: IntroductionController(),
                builder: (viewController) {
                  return buildFilledButton(
                    onPressCallback: () {
                      viewController.pauseTheVideo();

                      Get.to(() => SurveyPage())?.then(
                        (value) {
                          if (value != null && value is bool && value) {
                            viewController.playTheVideo();
                          }
                        },
                      );
                    },
                    backgroundColor: colorPrimary,
                    title: 'skip'.tr,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 24.0,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVideoPlayer(IntroductionController viewController) {
    return FutureBuilder(
      future: viewController.initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: viewController.videoController!.value.aspectRatio,
                child: VideoPlayer(viewController.videoController!),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 32.0,
                  right: 32.0,
                  top: 48.0,
                ),
                child: VideoProgressIndicator(
                  viewController.videoController!,
                  colors: VideoProgressColors(
                    backgroundColor: colorPrimary.withOpacity(0.2),
                    bufferedColor: colorPrimary.withOpacity(0.5),
                    playedColor: colorPrimary,
                  ),
                  allowScrubbing: true,
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
