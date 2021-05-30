import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/challenge/invite/challenge_invite_controller.dart';
import 'package:exammer/ui/competition/challenge/room/challenge_room.dart';
import 'package:exammer/ui/referral/invite/referral_invite_controller.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChallengeInvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Invite Friends",
            style: textStyleAppBar,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          brightness: Brightness.light,
          leadingWidth: 64.0,
          leading: IconButton(
            icon: buildBackButton(null),
            onPressed: () => Get.back(),
          ).marginOnly(left: 8.0),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: GetBuilder<ReferralInviteController>(
          init: ReferralInviteController(),
          builder: (viewController) {
            return viewController.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildContainerTopHood(),
                        Expanded(
                          child: buildBody(),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTopSection(),
          buildBottomSection(),
        ],
      ),
    );
  }

  Container buildTopSection() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          const Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorTextSecondary.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "https://bit.ly/3qnrUr7",
                    style: TextStyle(
                      color: colorTextSecondary,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).paddingSymmetric(
                    horizontal: 16.0,
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        ToastUtil.show("Copied to clipboard");
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: colorTextSecondary.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                        ),
                        child: Center(
                          child: Text(
                            "Copy",
                            style: TextStyle(
                              color: colorTextTertiary,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: colorTextSecondary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 56.0,
                ),
                child: Text(
                  "Or Share via",
                  style: TextStyle(
                    color: colorTextSecondary,
                    fontSize: 14.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Expanded(
                child: Divider(
                  color: colorTextSecondary,
                ),
              ),
            ],
          ).marginSymmetric(vertical: 24.0),
          buildFilledButton(
            title: "Share",
            onPressCallback: () {},
            padding: const EdgeInsets.only(
              left: 0.0,
              right: 0.0,
            ),
          ),
        ],
      ),
    );
  }

  Container buildBottomSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          const Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contacts",
            style: textStyleSectionTitle,
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          GetBuilder(
            init: ChallengeInviteController(),
            builder: (ChallengeInviteController viewController) {
              return ListView.separated(
                controller: viewController.scrollController,
                separatorBuilder: (context, index) => Divider(
                  height: 1.0,
                  color: colorTextSecondary,
                ),
                itemCount: 50,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(index);
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildItem(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              const Radius.circular(14.0),
            ),
            child: Image.network(
              "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
              fit: BoxFit.cover,
              width: 50.0,
              height: 50.0,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Charles L. Wenner",
                  style: textStyleSectionItemTitle,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).marginOnly(bottom: 4.0),
                Text(
                  "+8801962786756",
                  style: textStyleListHeader,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ).marginSymmetric(horizontal: 16.0),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 9.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              backgroundColor: colorTextSecondary.withOpacity(0.10),
            ),
            onPressed: () {
              Get.to(() => ChallengeRoomPage(personCount: 4));
            },
            child: Text(
              "Invite",
              style: textStyleFilledButton.copyWith(
                fontSize: 14.0,
                color: colorTextTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
