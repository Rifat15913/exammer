import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/courses/enrolled/enrolled_courses.dart';
import 'package:exammer/ui/notifications/view/notifications.dart';
import 'package:exammer/ui/others/faqs/faqs.dart';
import 'package:exammer/ui/referral/score/referral_score.dart';
import 'package:exammer/ui/store/view/store.dart';
import 'package:exammer/ui/wallet/my_account/my_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  bottom: 24.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: buildCloseButton(
                        () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      NavigationDrawerItem(
                        title: "Enrolled Courses",
                        imagePath: 'images/ic_enrolled_courses.png',
                        onTapCallback: () {
                          Get.back();
                          Get.to(() => EnrolledCoursesPage());
                        },
                      ),
                      NavigationDrawerItem(
                        title: "My Account",
                        imagePath: 'images/ic_my_account.png',
                        onTapCallback: () {
                          Get.back();
                          Get.to(() => MyAccountPage());
                        },
                      ),
                      NavigationDrawerItem(
                        title: "Notifications",
                        imagePath: 'images/ic_notifications.png',
                        onTapCallback: () {
                          Get.back();
                          Get.to(() => NotificationsPage());
                        },
                      ),
                      NavigationDrawerItem(
                        title: "Invite Friends",
                        imagePath: 'images/ic_invite_friends.png',
                        onTapCallback: () {
                          Get.back();
                          Get.to(() => ReferralScorePage());
                        },
                      ),
                      NavigationDrawerItem(
                        title: "FAQs",
                        imagePath: 'images/ic_faqs.png',
                        onTapCallback: () {
                          Get.back();
                          Get.to(() => FaqsPage());
                        },
                      ),
                      NavigationDrawerItem(
                        title: "Exammer Store",
                        imagePath: 'images/ic_exammer_store.png',
                        onTapCallback: () {
                          Get.back();
                          Get.to(() => StorePage());
                        },
                      ),
                      NavigationDrawerItem(
                        title: "Downloads",
                        imagePath: 'images/ic_downloads.png',
                        onTapCallback: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 48.0,
                ),
                child: NavigationDrawerItem(
                  title: "Log out",
                  imagePath: 'images/ic_sign_out.png',
                  onTapCallback: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationDrawerItem extends StatelessWidget {
  NavigationDrawerItem({
    required this.imagePath,
    required this.title,
    required this.onTapCallback,
  });

  final String imagePath;
  final String title;
  final GestureTapCallback onTapCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 24.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getLeading(),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Text(
                title,
                style: textStyleSectionTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLeading() {
    return Image.asset(
      imagePath,
      fit: BoxFit.fill,
      width: 24.0,
      height: 24.0,
    );
  }
}
