import 'package:exammer/base/helper/circular_outer_notched_rectangle.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/home/container/home_container_controller.dart';
import 'package:exammer/ui/home/container/navigation_drawer.dart';
import 'package:exammer/ui/profile/view/view_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeContainerPage extends StatelessWidget {
  HomeContainerPage({required this.userType});

  final int userType;
  final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        key: _keyScaffold,
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
          leading: IconButton(
            icon: Image.asset(
              'images/ic_drawer_opener.png',
              fit: BoxFit.fitHeight,
              height: 24.0,
            ),
            onPressed: () {
              _keyScaffold.currentState?.openDrawer();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            buildLanguageSwitch(),
            buildUserAvatar(),
          ],
        ),
        drawer: NavigationDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GetBuilder<HomeContainerController>(
          init: HomeContainerController(),
          builder: (viewController) {
            return InkWell(
              onTap: () {
                viewController.changeBottomBarIndex(2);
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorAccent,
                ),
                child: Image.asset(
                  'images/ic_competition.png',
                  fit: BoxFit.fitHeight,
                  height: 32.0,
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 30.0,
          //color: Colors.transparent,
          shape: CircularOuterNotchedRectangle(),
          notchMargin: 16.0,
          child: buildBottomBar(),
        ),
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

  GetBuilder<HomeContainerController> buildLanguageSwitch() {
    return GetBuilder<HomeContainerController>(
      id: 'switch_language',
      init: HomeContainerController(),
      builder: (viewController) {
        return Switch(
          activeColor: colorAccent,
          inactiveThumbColor: colorAccent,
          activeTrackColor: colorItemInactiveBackground,
          inactiveTrackColor: colorItemInactiveBackground,
          inactiveThumbImage: AssetImage('images/ic_thumb_english.png'),
          activeThumbImage: AssetImage('images/ic_thumb_bengali.png'),
          value: viewController.isBengaliSelected,
          onChanged: (isSelected) {
            viewController.changeLanguage(isSelected);
          },
        );
      },
    );
  }

  GestureDetector buildUserAvatar() {
    return GestureDetector(
      onTap: () {
        Get.to(() => ViewProfilePage());
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16.0,
          left: 8.0,
        ),
        child: Center(
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: colorUserActive,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              'home'.tr,
              0,
            ),
            getBottomBarItem(
              viewController,
              'images/ic_practice.png',
              'practice'.tr,
              1,
            ),
            getBottomBarItem(
              viewController,
              '',
              'competition'.tr,
              2,
            ),
            getBottomBarItem(
              viewController,
              'images/ic_courses.png',
              'courses'.tr,
              3,
            ),
            getBottomBarItem(
              viewController,
              'images/ic_jobs.png',
              'jobs'.tr,
              4,
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
