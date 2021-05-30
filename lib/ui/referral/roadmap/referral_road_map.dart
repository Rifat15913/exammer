import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/referral/invite/referral_invite.dart';
import 'package:exammer/ui/referral/roadmap/referral_road_map_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReferralRoadMapPage extends StatelessWidget {
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
        body: GetBuilder<ReferralRoadMapController>(
          init: ReferralRoadMapController(),
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

  Container buildBody() {
    return Container(
      margin: const EdgeInsets.all(16.0),
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
            "Invite Friends.\nGet Free 1000 Credits.",
            style: textStyleHoodTitle.copyWith(
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ).marginAll(16.0),
          Expanded(
            child: Image.asset(
              "images/ic_referral_road_map.png",
              fit: BoxFit.contain,
            ),
          ),
          Text(
            "Get 1000 credits for each friend after they make their first purchase",
            style: textStyleHoodSubtitle.copyWith(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ).marginOnly(top: 16.0, left: 32.0, right: 32.0),
          buildFilledButton(
            title: "Invite Friends",
            onPressCallback: () {
              Get.to(() => ReferralInvitePage());
            },
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 24.0,
            ),
          ),
          RichText(
            text: TextSpan(
              text: "Don\'t have referral ID?",
              style: textStyleCaption1.copyWith(
                fontSize: 14.0,
              ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showPopup();
                    },
                  text: " Register Now",
                  style: textStyleCaption2.copyWith(
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          ).marginOnly(
            top: 16.0,
            bottom: 16.0,
          ),
        ],
      ),
    );
  }

  void showPopup() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ), //this right here
        child: Container(
          //height: 500,
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 16.0,
          ),
          child: GetBuilder<ReferralRoadMapController>(
            id: "dialog_register_referral_id",
            init: ReferralRoadMapController(),
            builder: (ReferralRoadMapController viewController) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            'images/ic_close.png',
                            fit: BoxFit.fitHeight,
                            height: 24.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        "Register Referral ID",
                        style: TextStyle(
                          color: colorTextRegular,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ).marginOnly(
                      top: 16.0,
                      bottom: 16.0,
                    ),
                    Text(
                      "Register your referral ID for refer and earn more points.",
                      style: textStylePopupMenuTitle,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ).paddingSymmetric(horizontal: 24.0),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorTextSecondary.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            child: Text(
                              "120 Taka",
                              style: TextStyle(
                                color: colorTextSecondary,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: colorAccent,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Register Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).marginOnly(top: 32.0),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
