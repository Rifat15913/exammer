import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/challenge/challenge_competition_controller.dart';
import 'package:exammer/ui/competition/challenge/invite/challenge_invite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChallengeCompetitionPage extends StatelessWidget {
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
        body: GetBuilder<ChallengeCompetitionController>(
          init: ChallengeCompetitionController(),
          builder: (controller) {
            return controller.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildContainerTopHood(),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                buildTopSection(),
                                buildBottomSection(),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0),
                            ),
                          ),
                          child: buildFilledButton(
                            onPressCallback: () {
                              Get.to(() => ChallengeInvitePage());
                            },
                            backgroundColor: colorPrimary,
                            title: "Proceed",
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildTopSection() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Challenge Type",
                style: textStyleSectionTitle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            GetBuilder<ChallengeCompetitionController>(
              id: "chips_challenge_type",
              init: ChallengeCompetitionController(),
              builder: (viewController) {
                return Wrap(
                  children: buildChallengeTypeList(viewController),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildChallengeTypeList(
    ChallengeCompetitionController viewController,
  ) {
    List<Widget> list = [];

    for (int i = 0; i < 3; i++) {
      bool isSelected = viewController.selectedIndexMap.containsKey('top') &&
          viewController.selectedIndexMap['top'] == i;

      list.add(
        Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            bottom: 8.0,
          ),
          child: ChoiceChip(
            label: Text(
              '${i + 1} v ${i + 1}',
              style: TextStyle(
                color: isSelected ? Colors.white : colorTextTertiary,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: colorTextSecondary.withOpacity(0.15),
            selectedColor: colorItemActiveBackground,
            selected: isSelected,
            onSelected: (bool selected) {
              if (selected) {
                viewController.selectItemFromTopSection(i);
              } else {
                viewController.deselectItemFromTopSection(i);
              }
            },
          ),
        ),
      );
    }

    return list;
  }

  Widget buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Choose Topic",
                style: textStyleSectionTitle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            GetBuilder<ChallengeCompetitionController>(
              id: "chips_topic",
              init: ChallengeCompetitionController(),
              builder: (viewController) {
                return Wrap(
                  children: buildTopicList(viewController),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildTopicList(
    ChallengeCompetitionController viewController,
  ) {
    List<Widget> list = [];

    for (int i = 0; i < 10; i++) {
      bool isSelected = viewController.selectedIndexMap.containsKey('bottom') &&
          viewController.selectedIndexMap['bottom'] == i;

      list.add(
        Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            bottom: 8.0,
          ),
          child: ChoiceChip(
            label: Text(
              'Topic ${i + 1}',
              style: TextStyle(
                color: isSelected ? Colors.white : colorTextSecondary,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            padding: const EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: colorTextSecondary.withOpacity(0.15),
            selectedColor: colorItemActiveBackground,
            selected: isSelected,
            onSelected: (bool selected) {
              if (selected) {
                viewController.selectItemFromBottomSection(i);
              } else {
                viewController.deselectItemFromBottomSection(i);
              }
            },
          ),
        ),
      );
    }

    return list;
  }
}
