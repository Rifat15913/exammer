import 'package:exammer/base/widget/central_empty_list_placeholder.dart';
import 'package:exammer/base/widget/central_error_placeholder.dart';
import 'package:exammer/base/widget/central_progress_indicator.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/model/dashboard/course/data/course_data.dart';
import 'package:exammer/data/remote/model/dashboard/feedback/feedback.dart'
    as dashboard;
import 'package:exammer/data/remote/repository/remote_repository.dart';
import 'package:exammer/data/remote/response/get_dashboard_data_response.dart';
import 'package:exammer/ui/courses/archive/course_archive.dart';
import 'package:exammer/ui/home/content/home_content_controller.dart';
import 'package:exammer/ui/referral/score/referral_score.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        body: GetBuilder<HomeContentController>(
          init: HomeContentController(),
          builder: (controller) {
            return controller.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: FutureBuilder<GetDashboardDataResponse>(
                      future: RemoteRepository.on().getDashboardData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!.dashboardData;

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(24.0),
                                    bottomRight: Radius.circular(24.0),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showPopup(
                                          context,
                                          "images/ic_question_answer.png",
                                          "Take a new challange to grow up your points",
                                          "Anger antiquity puzzles right that pleasure lowest mostly of equally being time dressed the were so that of want whom back hero's history; From earnestly relative the so concept.",
                                        );
                                      },
                                      child: Text(
                                        "Hey! Mahmud",
                                        style: textStyleHoodTitle,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text:
                                                  'Your Tekka Account Point is now ',
                                              style: textStyleHoodSubtitle,
                                              children: [
                                                TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          showPopup(
                                                            context,
                                                            "images/ic_clipboard.png",
                                                            'Exam test will be held on 9:00 AM',
                                                            "Anger antiquity puzzles right that pleasure lowest mostly of equally being time dressed the were so that of want whom back hero's history; From earnestly relative the so concept.",
                                                          );
                                                        },
                                                  text: '1203',
                                                  style: textStyleHoodSubtitle
                                                      .copyWith(
                                                    color: colorAccent,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          buildPopUpMenuForPoints(context),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      buildBannerSegment(),
                                      buildExpertPanelSegment(),
                                      buildTournamentSegment(),
                                      buildExpertPickSegment(
                                        list: data.courses.experts,
                                      ),
                                      buildTrendingCourseSegment(
                                        list: data.courses.trending,
                                      ),
                                      buildChallengeSegment(),
                                      buildCustomerFeedbackSegment(
                                        shouldSetPaddingAtBottom: true,
                                        shouldShowSeeAll: false,
                                        feedbackList: data.feedbacks,
                                      ),
                                      buildReferralSegment(),
                                      buildStatisticsSegment(),
                                      SizedBox(height: 56),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return CentralErrorPlaceholder(
                            message: "${snapshot.error}",
                          );
                        }
                        return const CentralProgressIndicator();
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildPopUpMenuForPoints(BuildContext context) {
    return GetBuilder<HomeContentController>(
      init: HomeContentController(),
      builder: (viewController) {
        return GestureDetector(
          onTap: () {
            showMenu(
              shape: shapeCardItemRectangle,
              context: context,
              position: viewController.buildRectForPointsMenu(context),
              items: <PopupMenuEntry>[
                const PopupMenuItem(
                  enabled: false,
                  child: ListTile(
                    dense: true,
                    leading: Text(
                      'Referral',
                      style: textStylePopupMenuTitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: Text(
                      '450 TC',
                      style: textStylePopupMenuSubtitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  enabled: false,
                  child: ListTile(
                    dense: true,
                    leading: Text(
                      'Signup',
                      style: textStylePopupMenuTitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: Text(
                      '300 TC',
                      style: textStylePopupMenuSubtitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            );
          },
          onTapDown: viewController.storePosition,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Icon(
              Icons.contact_support_outlined,
              color: colorTextSecondary,
              size: 16.0,
            ),
          ),
        );
      },
    );
  }

  Widget buildStatisticsSegment() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      padding: const EdgeInsets.all(32.0),
      decoration: boxDecorationSectionCardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: buildStatisticsItem(
                  imagePath: "images/ic_live_users.png",
                  title: "Live Users",
                  subtitle: "300+",
                ),
              ),
              Expanded(
                child: buildStatisticsItem(
                  imagePath: "images/ic_courses_bought.png",
                  title: "Courses Bought",
                  subtitle: "300+",
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 32.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: buildStatisticsItem(
                    imagePath: "images/ic_total_challenges.png",
                    title: "Total Challenges",
                    subtitle: "300+",
                  ),
                ),
                Expanded(
                  child: buildStatisticsItem(
                    imagePath: "images/ic_lives_changed.png",
                    title: "Lives Changed",
                    subtitle: "300+",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReferralSegment() {
    return GestureDetector(
      onTap: () {
        Get.to(() => ReferralScorePage());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: ClipRRect(
          child: AspectRatio(
            aspectRatio: 382.0 / 158,
            child: Image.asset(
              "images/ic_home_refer_banner.png",
              fit: BoxFit.fill,
            ),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  Widget buildExpertPickSegment({
    bool shouldShowSeeAll = true,
    bool shouldSetPaddingAtBottom = false,
    required List<CourseData> list,
  }) {
    return Padding(
      padding: shouldSetPaddingAtBottom
          ? const EdgeInsets.all(16.0)
          : const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'home_expert_picks'.tr,
                    style: textStyleSectionTitle,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if (shouldShowSeeAll)
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'see_all'.tr,
                        style: textStyleSectionSubtitle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                height: 140,
                child: list.isEmpty
                    ? const CentralEmptyListPlaceholder()
                    : ListView.separated(
                        physics: PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final item = list[index];
                          return buildExpertPickItem(item);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 12.0,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpertPickItem(CourseData item) {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        child: Image.network(
          "https://www.tutorialandexample.com/wp-content/uploads/2019/09/Python-Tutorial-q-1024x490.jpg",
          fit: BoxFit.cover,
          height: 140,
          width: 160,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  Widget buildTrendingCourseSegment({
    bool shouldShowSeeAll = true,
    bool shouldSetPaddingAtBottom = false,
    required List<CourseData> list,
  }) {
    return Padding(
      padding: shouldSetPaddingAtBottom
          ? const EdgeInsets.all(16.0)
          : const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'home_trending_courses'.tr,
                    style: textStyleSectionTitle,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if (shouldShowSeeAll)
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CourseArchivePage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'see_all'.tr,
                        style: textStyleSectionSubtitle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                height: 260,
                child: list.isEmpty
                    ? const CentralEmptyListPlaceholder()
                    : ListView.separated(
                        physics: PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final item = list[index];
                          return buildCourseItem(item);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 12.0,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseItem(CourseData item) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: shapeCardItemRectangle,
        child: Container(
          width: 200,
          child: Column(
            children: [
              ClipRRect(
                child: Image.network(
                  "https://edu.google.com/images/social_image.jpg",
                  fit: BoxFit.cover,
                  height: 150,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        item.name,
                        style: textStyleRegularBody,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 16.0,
                        top: 4.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "images/ic_lesson.png",
                                fit: BoxFit.fitHeight,
                                height: 24,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  "17 lessons",
                                  style: textStyleSmallestBody,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                  "images/ic_clock.png",
                                  fit: BoxFit.fitHeight,
                                  height: 24,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "4h 15m",
                                    style: textStyleSmallestBody,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExpertPanelSegment({
    bool shouldShowSeeAll = true,
    bool shouldSetPaddingAtBottom = false,
  }) {
    return Padding(
      padding: shouldSetPaddingAtBottom
          ? const EdgeInsets.all(16.0)
          : const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Expert Panel',
                    style: textStyleSectionTitle,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if (shouldShowSeeAll)
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'see_all'.tr,
                        style: textStyleSectionSubtitle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                height: 200,
                child: ListView.separated(
                  physics: PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: 50,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return buildExpertPanelItem();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 12.0,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpertPanelItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 110,
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(
                "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                fit: BoxFit.cover,
                height: 110,
                width: 100,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "J. Smith",
                      style: textStyleSectionItemTitle,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 4.0,
                    ),
                    child: Text(
                      "Professor of English Professor of English Professor of English",
                      style: textStyleSmallestBody,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBannerSegment({
    bool shouldSetPaddingAtBottom = false,
  }) {
    return Padding(
      padding: shouldSetPaddingAtBottom
          ? const EdgeInsets.all(16.0)
          : const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
      child: Container(
        height: 140,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return buildBannerItem();
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 12.0,
            );
          },
        ),
      ),
    );
  }

  Widget buildBannerItem() {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        child: Image.asset(
          "images/dummy_home_banner.png",
          fit: BoxFit.cover,
          height: 140,
          width: 288,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
    );
  }

  Widget buildTournamentSegment({
    bool shouldSetPaddingAtBottom = false,
  }) {
    return Padding(
      padding: shouldSetPaddingAtBottom
          ? const EdgeInsets.all(16.0)
          : const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
      child: Container(
        height: 140,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return buildTournamentItem();
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 12.0,
            );
          },
        ),
      ),
    );
  }

  Widget buildTournamentItem() {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        child: Image.asset(
          "images/dummy_home_tournament.png",
          fit: BoxFit.cover,
          height: 140,
          width: 160,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Widget buildChallengeSegment({
    bool shouldSetPaddingAtBottom = false,
  }) {
    return Padding(
      padding: shouldSetPaddingAtBottom
          ? const EdgeInsets.all(16.0)
          : const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
      child: Container(
        height: 107,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return buildChallengeItem();
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 12.0,
            );
          },
        ),
      ),
    );
  }

  Widget buildChallengeItem() {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        child: Image.asset(
          "images/dummy_home_challenge.png",
          fit: BoxFit.cover,
          height: 107,
          width: 116,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Widget buildCustomerFeedbackSegment({
    bool shouldShowSeeAll = true,
    bool shouldSetPaddingAtBottom = false,
    required List<dashboard.Feedback> feedbackList,
  }) {
    return Padding(
      padding: shouldSetPaddingAtBottom
          ? const EdgeInsets.all(16.0)
          : const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'home_customer_feedback'.tr,
                    style: textStyleSectionTitle,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if (shouldShowSeeAll)
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'see_all'.tr,
                        style: textStyleSectionSubtitle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                height: 150,
                child: feedbackList.isEmpty
                    ? const CentralEmptyListPlaceholder()
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: feedbackList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final item = feedbackList[index];
                          return buildCustomerFeedbackItem(item);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 12.0,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomerFeedbackItem(dashboard.Feedback item) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: colorInputFieldBorder),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 15,
                  backgroundImage: NetworkImage(
                    item.profilePicture,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    item.name,
                    style: textStyleSectionItemTitle,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                item.content ?? defaultString,
                style: TextStyle(
                  color: colorTextRegular,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatisticsItem({
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.fitHeight,
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 2.0,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: colorTextSecondary,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: colorTextRegular,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void showPopup(
    BuildContext context,
    String imagePath,
    String title,
    String subtitle,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ), //this right here
          child: Container(
            height: 440,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 24.0,
            ),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 24.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Image.asset(
                        imagePath,
                        fit: BoxFit.fitHeight,
                        height: 80.0,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 24.0,
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: colorTextTertiary,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                FlatButton(
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  color: colorAccent,
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
