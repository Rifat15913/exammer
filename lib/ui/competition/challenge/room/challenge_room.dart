import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/challenge/result/challenge_result.dart';
import 'package:exammer/ui/competition/challenge/room/challenge_room_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChallengeRoomPage extends StatelessWidget {
  final int personCount;

  ChallengeRoomPage({required this.personCount});

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
        body: GetBuilder<ChallengeRoomController>(
          init: ChallengeRoomController(),
          builder: (controller) {
            return controller.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildContainerTopHood(),
                        buildGameInformationWidget(),
                        buildPlayerInformationWidget(),
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
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          const Radius.circular(20.0),
        ),
      ),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "${this.personCount} v ${this.personCount}",
            style: textStyleSectionTitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ).marginOnly(bottom: 8.0),
          Text(
            "Topic: Algebra",
            style: textStyleSectionTitle.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget buildPlayerInformationWidget() {
    const String dummyAvatar =
        "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg";

    List<Widget> team1 = [];
    List<Widget> team2 = [];

    for (int i = 0; i < this.personCount; i++) {
      team1.add(
        PlayerAvatarWidget(
          name: "Team1 Player ${i + 1}",
          imageURL: dummyAvatar,
        ),
      );

      team2.add(
        PlayerAvatarWidget(
          name: "Team2 Player ${i + 1}",
          imageURL: dummyAvatar,
        ),
      );

      if (i != this.personCount - 1) {
        team1.add(
          SizedBox(width: 12.0),
        );

        team2.add(
          SizedBox(width: 12.0),
        );
      }
    }

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            const Radius.circular(20.0),
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: team1),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    height: 2.0,
                    color: colorTextSecondary,
                  ),
                ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: const Border.fromBorderSide(
                      const BorderSide(color: colorTextSecondary),
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      "VS",
                      style: const TextStyle(
                        color: colorTextSecondary,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 2.0,
                    color: colorTextSecondary,
                  ),
                ),
              ],
            ),
            Row(children: team2),
          ],
        ),
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
          Get.to(() => ChallengeResultPage());
        },
        backgroundColor: colorPrimary,
        title: "Start",
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 24.0,
        ),
      ),
    );
  }
}

class PlayerAvatarWidget extends StatelessWidget {
  final String imageURL;
  final String name;
  final int extraPaddingFromScreenWall = 64;
  final int maxPersonCount = 4;

  const PlayerAvatarWidget({
    Key? key,
    required this.name,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRowWidth = (screenWidth - extraPaddingFromScreenWall);
    final widthOfEachAvatar = (avatarRowWidth / maxPersonCount);

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: widthOfEachAvatar / 2,
            backgroundImage: NetworkImage(this.imageURL),
          ).marginOnly(bottom: 8.0),
          Text(
            this.name,
            style: textStyleCaption1.copyWith(
              color: colorTextRegular,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
