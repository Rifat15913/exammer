import 'package:exammer/constants.dart';
import 'package:exammer/ui/auth/login/login.dart';
import 'package:exammer/ui/home/container/home_container_controller.dart';
import 'package:exammer/ui/quiz/add/add_quiz.dart';
import 'package:exammer/util/lib/preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeContainerPage extends StatelessWidget {
  HomeContainerPage({required this.userType});

  final int userType;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: GetBuilder<HomeContainerController>(
            id: "text_app_bar_title",
            init: HomeContainerController(),
            builder: (viewController) {
              return Text(
                viewController.appBarTitle,
                style: textStyleAppBar,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              );
            },
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            AppBarActionItem(
              title: "Log out",
              imagePath: 'images/ic_sign_out.png',
              onTapCallback: () async {
                FirebaseAuth.instance.signOut();
                PreferenceUtil.on.clear();
                Get.offAll(() => LoginPage());
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: userType == userTypeTeacher
            ? GetBuilder<HomeContainerController>(
                init: HomeContainerController(),
                builder: (viewController) {
                  return FloatingActionButton.extended(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    backgroundColor: colorAccent,
                    onPressed: () {
                      Get.to(() => AddQuizPage());
                    },
                    label: Text("Add exam"),
                  );
                },
              )
            : null,
        bottomNavigationBar: buildBottomBar(),
        body: GetBuilder<HomeContainerController>(
          id: 'body',
          init: HomeContainerController(),
          builder: (controller) {
            return SafeArea(
              child: controller.body,
            );
          },
        ),
      ),
    );
  }

  Widget buildBottomBar() {
    return GetBuilder<HomeContainerController>(
      id: 'bottom_bar',
      init: HomeContainerController(),
      builder: (HomeContainerController viewController) {
        return BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          currentIndex: viewController.selectedBottomBarIndex,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          selectedItemColor: colorTextRegular,
          unselectedItemColor: colorTextSecondary,
          items: [
            getBottomBarItem(
              viewController,
              'images/ic_home.png',
              "Exam",
              0,
            ),
            getBottomBarItem(
              viewController,
              'images/ic_practice.png',
              'profile'.tr,
              1,
            ),
          ],
          onTap: (index) {
            viewController.changeBottomBarIndex(index);
          },
        );
      },
    );
  }

  BottomNavigationBarItem getBottomBarItem(
    HomeContainerController viewController,
    String imagePath,
    String title,
    int position,
  ) {
    return BottomNavigationBarItem(
      icon: imagePath.trim().isNotEmpty
          ? (position == viewController.selectedBottomBarIndex
              ? Image.asset(
                  imagePath,
                  fit: BoxFit.fitHeight,
                  height: 32.0,
                )
              : Image.asset(
                  imagePath,
                  fit: BoxFit.fitHeight,
                  height: 32.0,
                  color: colorTextSecondary,
                ))
          : SizedBox(height: 32.0),
      label: title,
    );
  }
}

class AppBarActionItem extends StatelessWidget {
  AppBarActionItem({
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
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getLeading(),
            SizedBox(
              width: 8.0,
            ),
            Text(
              title,
              style: textStyleSectionTitle.copyWith(
                fontSize: 14.0,
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
      width: 20.0,
      height: 20.0,
    );
  }
}
