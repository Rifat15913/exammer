import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/profile/edit/edit_profile.dart';
import 'package:exammer/ui/profile/view/view_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ViewProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Profile",
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
            buildEditProfileTrigger(),
          ],
        ),
        body: GetBuilder<ViewProfileController>(
          init: ViewProfileController(),
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
                          child: buildMainBody(),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildEditProfileTrigger() {
    return GestureDetector(
      onTap: () {
        Get.to(() => EditProfilePage());
      },
      child: Center(
        child: Text(
          "Edit",
          style: textStyleSectionTitle.copyWith(
            color: colorAccent,
          ),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ).paddingOnly(right: 16.0),
    );
  }

  Widget buildMainBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: boxDecorationSectionCardBackground,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorPageBackground,
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: colorAccent,
                      width: 2.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Image.network(
                      "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ).marginSymmetric(vertical: 16.0),
                Text(
                  "Mahmudul Hasan",
                  style: textStyleHoodTitle.copyWith(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "Beginner",
                  style: textStyleHoodSubtitle,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ).marginOnly(top: 4.0, bottom: 16.0),
                IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "manikhax@gmail.com",
                          style: textStyleCaption2.copyWith(
                            color: colorTextRegular,
                          ),
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      VerticalDivider(
                        color: colorTextSecondary,
                        thickness: 2.0,
                      ).marginSymmetric(horizontal: 8.0),
                      Expanded(
                        child: Text(
                          "+8801876-999888",
                          style: textStyleCaption2.copyWith(
                            color: colorTextRegular,
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: buildStatisticsItem(
                        imagePath: "images/ic_clipboard.png",
                        title: "42.20%",
                        subtitle: "Completed",
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: buildStatisticsItem(
                        imagePath: "images/ic_trophy.png",
                        title: "10,389",
                        subtitle: "Points",
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: buildStatisticsItem(
                        imagePath: "images/ic_result.png",
                        title: "+23",
                        subtitle: "Level up",
                      ),
                    ),
                  ],
                ).marginOnly(top: 24.0),
              ],
            ),
          ).marginAll(16.0),
          GetBuilder<ViewProfileController>(
            init: ViewProfileController(),
            id: "score_view",
            builder: (viewController) {
              return Container(
                decoration: boxDecorationSectionCardBackground,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Score",
                          style: textStyleSectionTitle,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        DropdownButton<String>(
                          icon: Image.asset(
                            'images/ic_dropdown_arrow.png',
                            fit: BoxFit.fitHeight,
                            height: 20.0,
                          ),
                          style: textStylePopupMenuTitle,
                          items: <String>["Math", "Science", "English"].map(
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
                          value: viewController.selectedSubject,
                          underline: SizedBox(),
                          isExpanded: false,
                        ),
                      ],
                    ).marginOnly(bottom: 16.0),
                    Container(
                      height: 200,
                      child: charts.TimeSeriesChart(
                        _createSampleData(),
                        animate: false,
                        // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                        // should create the same type of [DateTime] as the data provided. If none
                        // specified, the default creates local date time.
                        dateTimeFactory: const charts.LocalDateTimeFactory(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!viewController.isMonthlyScore) {
                              viewController.toggleScoreView();
                            }
                          },
                          child: Container(
                            child: Text(
                              "Monthly",
                              style: textStyleSectionSubtitle.copyWith(
                                color: viewController.isMonthlyScore
                                    ? Colors.white
                                    : colorAccent,
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: viewController.isMonthlyScore
                                  ? colorAccent
                                  : colorItemInactiveBackground,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            if (viewController.isMonthlyScore) {
                              viewController.toggleScoreView();
                            }
                          },
                          child: Container(
                            child: Text(
                              "Weekly",
                              style: textStyleSectionSubtitle.copyWith(
                                color: !viewController.isMonthlyScore
                                    ? Colors.white
                                    : colorAccent,
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: !viewController.isMonthlyScore
                                  ? colorAccent
                                  : colorItemInactiveBackground,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                      ],
                    ).marginOnly(top: 16.0),
                  ],
                ),
              ).marginOnly(left: 16.0, right: 16.0, bottom: 16.0);
            },
          ),
        ],
      ),
    );
  }

  Widget buildStatisticsItem({
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: colorPageBackground,
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.fitHeight,
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 2.0,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: colorTextRegular,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: colorTextSecondary,
              fontSize: 11.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
