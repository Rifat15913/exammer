import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/practice/improvement/improvement_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ImprovementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
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
              child: GestureDetector(
                onTap: () {
                  showPopup();
                },
                child: Text(
                  "Suggested Courses",
                  style: textStyleSectionSubtitle.copyWith(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ).marginOnly(right: 16.0),
          ],
        ),
        body: GetBuilder<ImprovementController>(
          init: ImprovementController(),
          builder: (viewController) {
            return viewController.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildContainerTopHood(),
                        buildBanner(viewController),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 16.0,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Position : ",
                                  style: textStylePopupMenuTitle.copyWith(
                                    fontSize: 14.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "4th",
                                      style: textStyleSectionTitle.copyWith(
                                        fontSize: 14.0,
                                      ),
                                    )
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 56,
                                    width: 100,
                                    child: charts.TimeSeriesChart(
                                      _createSampleData(),
                                      animate: false,
                                      primaryMeasureAxis:
                                          const charts.NumericAxisSpec(
                                        renderSpec:
                                            const charts.NoneRenderSpec(),
                                        showAxisLine: false,
                                      ),
                                      domainAxis: const charts.DateTimeAxisSpec(
                                        showAxisLine: false,
                                        renderSpec:
                                            const charts.NoneRenderSpec(),
                                      ),
                                      dateTimeFactory:
                                          const charts.LocalDateTimeFactory(),
                                    ),
                                  ),
                                  Text(
                                    "+ 10%",
                                    style: textStyleSectionTitle.copyWith(
                                      color: colorAccent,
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: buildSegment(),
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

  Container buildBanner(ImprovementController viewController) {
    return Container(
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: colorAccent,
        borderRadius: const BorderRadius.all(
          const Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          Text(
            "English Vocabulary Test",
            style: textStyleHoodTitle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ).marginOnly(top: 8.0),
          Divider(
            color: Colors.white.withOpacity(0.3),
          ).marginOnly(top: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "73 of 100 Points",
                style: textStyleHoodTitle.copyWith(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              DropdownButton<String>(
                dropdownColor: Colors.black,
                icon: Image.asset(
                  'images/ic_dropdown_arrow.png',
                  fit: BoxFit.fitHeight,
                  height: 20.0,
                  color: Colors.white,
                ),
                style: textStylePopupMenuTitle.copyWith(
                  color: Colors.white,
                ),
                items: <String>["Today", "This Month", "This Year"].map(
                  (String dropdownItem) {
                    return DropdownMenuItem<String>(
                      value: dropdownItem,
                      child: Text(dropdownItem),
                    );
                  },
                ).toList(),
                onChanged: (String? newlySelectedValue) {
                  if (newlySelectedValue != null) {
                    viewController.changeSubject(newlySelectedValue);
                  }
                },
                value: viewController.selectedTime,
                underline: SizedBox(),
                isExpanded: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildBottomSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "Total",
              style: textStyleAppBar.copyWith(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(
            "55",
            style: textStylePageTitle.copyWith(
              color: colorAccent,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            " / 75",
            style: textStylePageTitle.copyWith(
              color: colorTextSecondary,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ).marginAll(16.0),
    );
  }

  Widget buildSegment() {
    return GetBuilder<ImprovementController>(
      id: "list_view_improvement_items",
      init: ImprovementController(),
      builder: (viewController) {
        return Container(
          decoration: boxDecorationSectionCardBackground,
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            controller: viewController.scrollController,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: Divider(
                height: 1.0,
                color: colorTextSecondary,
              ),
            ),
            itemCount: 50,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return buildItem(index);
            },
          ),
        ).marginAll(16.0);
      },
    );
  }

  Widget buildItem(int index) {
    return GetBuilder<ImprovementController>(
      init: ImprovementController(),
      builder: (viewController) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              margin: const EdgeInsets.only(right: 8.0),
              child: Text(
                "${(index + 1).toString().padLeft(2, '0')}.",
                style: textStyleSectionItemTitle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          "Short Exam",
                          style: textStyleSectionItemTitle,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/ic_user_enrolled.png',
                            fit: BoxFit.fitHeight,
                            height: 16.0,
                          ).marginOnly(right: 8.0),
                          Text(
                            "100 Enrolled",
                            style: textStyleCaption1.copyWith(
                              color: colorTextRegular,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: colorTextSecondary.withOpacity(0.4),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "3rd",
                          style: textStylePopupMenuTitle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Text(
                        "55",
                        style: textStylePageTitle.copyWith(
                          color: colorAccent,
                          fontSize: 14.0,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        " / 75",
                        style: textStylePageTitle.copyWith(
                          color: colorTextSecondary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  Divider(
                    color: colorTextSecondary.withOpacity(0.4),
                  ),
                  Text(
                    "21 Jul, 2020",
                    style: textStyleCaption1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        );
      },
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
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 24.0,
          ),
          child: SingleChildScrollView(
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
                Text(
                  "You're lagging behind maximum users. 90% users doing below courses and have achievement.",
                  style: textStyleSectionTitle,
                  textAlign: TextAlign.center,
                ).marginOnly(
                  top: 16.0,
                  bottom: 24.0,
                  left: 16.0,
                  right: 16.0,
                ),
                buildCourseSegment(),
                buildStudentFeedbackSegment(
                  shouldShowSeeAll: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStudentFeedbackSegment({
    bool shouldShowSeeAll = true,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  'Student Feedback',
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
              child: GetBuilder<ImprovementController>(
                init: ImprovementController(),
                builder: (ImprovementController viewController) {
                  return ListView.separated(
                    controller: viewController.dialogFeedbackScrollController,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return buildStudentFeedbackItem();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 12.0,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStudentFeedbackItem() {
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
                    "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    "John Smith Doe",
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
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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

  Widget buildCourseSegment({
    bool shouldShowSeeAll = true,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        top: 0.0,
        bottom: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  'Recommended Courses',
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
              height: 280,
              child: GetBuilder<ImprovementController>(
                init: ImprovementController(),
                builder: (ImprovementController viewController) {
                  return ListView.separated(
                    controller: viewController.dialogCourseScrollController,
                    physics: PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: 50,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCourseItem();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 12.0,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCourseItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: colorInputFieldBorder),
        ),
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
                      "English Advance Learning Course",
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
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(6.0),
                        ),
                      ),
                      backgroundColor: colorAccent,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Enroll Now",
                      style: textStyleFilledButton.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ).marginSymmetric(horizontal: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      TimeSeriesSales(DateTime(2017, 9, 19), 5),
      TimeSeriesSales(DateTime(2017, 9, 26), 25),
      TimeSeriesSales(DateTime(2017, 10, 3), 100),
      TimeSeriesSales(DateTime(2017, 10, 10), 75),
      TimeSeriesSales(DateTime(2018, 1, 1), 150),
      TimeSeriesSales(DateTime(2018, 2, 1), 125),
      TimeSeriesSales(DateTime(2018, 3, 1), 175),
      TimeSeriesSales(DateTime(2018, 4, 1), 150),
      TimeSeriesSales(DateTime(2018, 5, 1), 200),
      TimeSeriesSales(DateTime(2018, 6, 1), 300),
      TimeSeriesSales(DateTime(2018, 7, 1), 450),
      TimeSeriesSales(DateTime(2018, 8, 1), 500),
      TimeSeriesSales(DateTime(2018, 9, 1), 450),
      TimeSeriesSales(DateTime(2018, 10, 1), 475),
      TimeSeriesSales(DateTime(2018, 11, 1), 400),
      TimeSeriesSales(DateTime(2018, 12, 1), 450),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
