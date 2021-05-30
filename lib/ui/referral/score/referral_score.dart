import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/referral/roadmap/referral_road_map.dart';
import 'package:exammer/ui/referral/score/referral_score_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ReferralScorePage extends StatelessWidget {
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
          actions: [
            Center(
              child: Text(
                "Level 2",
                style: textStyleSectionSubtitle.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ).marginOnly(right: 16.0),
          ],
        ),
        body: GetBuilder<ReferralScoreController>(
          init: ReferralScoreController(),
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
                        buildBottomSection(),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Container buildBottomSection() {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
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
          Text(
            "Get 1000 credits for each friend after they make their first purchase",
            style: textStyleHoodSubtitle.copyWith(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ).paddingSymmetric(horizontal: 32.0).marginOnly(top: 8.0),
          buildFilledButton(
            title: "Get Started",
            onPressCallback: () {
              Get.to(() => ReferralRoadMapPage());
            },
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 24.0),
          )
        ],
      ),
    );
  }

  Widget buildBody() {
    return GetBuilder<ReferralScoreController>(
      init: ReferralScoreController(),
      builder: (viewController) {
        return Container(
          child: Stack(
            children: [
              Container(
                decoration: boxDecorationSectionCardBackground,
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                  top: 56.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'images/ic_crown.png',
                          fit: BoxFit.fitHeight,
                          height: 32.0,
                        ).marginOnly(right: 4.0),
                        Text(
                          "Jasmin G.",
                          style: textStyleSectionTitle.copyWith(
                            fontSize: 22.0,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Text(
                      "Points : 20,805,389",
                      style: textStylePopupMenuTitle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ).marginOnly(top: 4.0, bottom: 16.0),
                    Expanded(
                      child: StaggeredGridView.countBuilder(
                        controller: viewController.scrollController,
                        staggeredTileBuilder: (int index) {
                          return StaggeredTile.fit(1);
                        },
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        crossAxisCount: 3,
                        itemCount: 30,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return buildItem(index);
                        },
                      ),
                    ),
                  ],
                ),
              ).marginOnly(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
                top: 68.0,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: colorPageBackground,
                      radius: 56,
                      child: CircleAvatar(
                        backgroundColor: colorPageBackground,
                        radius: 48,
                        backgroundImage: NetworkImage(
                          "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: const BoxDecoration(
                          color: colorAccent,
                          shape: BoxShape.circle,
                          border: const Border.fromBorderSide(
                            const BorderSide(
                              color: colorExamItemInactiveBackground,
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "10",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).marginOnly(top: 12.0),
            ],
          ),
        );
      },
    );
  }

  Widget buildItem(int index) {
    return GetBuilder<ReferralScoreController>(
      init: ReferralScoreController(),
      builder: (viewController) {
        return Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage: NetworkImage(
                    "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: colorTextSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Kenneth C.",
              style: textStyleSectionItemTitle,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ).marginOnly(top: 8.0, bottom: 4.0),
            Text(
              "1,498,035",
              style: textStylePopupMenuTitle.copyWith(
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        );
      },
    );
  }
}
