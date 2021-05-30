import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/practice/category/practice_category.dart';
import 'package:exammer/ui/practice/improvement/improvement.dart';
import 'package:exammer/ui/practice/progress/progress.dart';
import 'package:exammer/ui/practice/wrapper/practice_wrapper_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PracticeWrapperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        body: GetBuilder<PracticeWrapperController>(
          init: PracticeWrapperController(),
          builder: (controller) {
            if (controller.isLoading) {
              return centralProgressIndicator;
            } else {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildContainerTopHood(),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildTopSection(),
                            buildProgressSection(),
                            buildImprovementSection(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Container buildTopSection() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16.0,
        top: 16.0,
        right: 16.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          const Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'You can participate in Exam',
            style: textStyleSectionTitle,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildExamType(
                'images/ic_quiz.png',
                'Short Exam',
                () {
                  Get.to(() => PracticeCategoryPage());
                },
              ),
              SizedBox(width: 16.0),
              buildExamType(
                'images/ic_question_answer.png',
                'Full Exam',
                () {
                  Get.to(() => PracticeCategoryPage());
                },
              ),
            ],
          ).marginOnly(top: 16.0),
        ],
      ),
    );
  }

  Widget buildProgressSection() {
    return GetBuilder<PracticeWrapperController>(
      init: PracticeWrapperController(),
      builder: (viewController) {
        return InkWell(
          onTap: () {
            Get.to(() => ProgressPage());
          },
          child: Container(
            margin: const EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              right: 16.0,
            ),
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
              top: 4.0,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: textStyleSectionTitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    DropdownButton<String>(
                      icon: Image.asset(
                        'images/ic_dropdown_arrow.png',
                        fit: BoxFit.fitHeight,
                        height: 20.0,
                      ),
                      style: textStylePopupMenuTitle,
                      items: <String>["This Month", "This Year"].map(
                        (String dropdownItem) {
                          return DropdownMenuItem<String>(
                            value: dropdownItem,
                            child: Text(dropdownItem),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newlySelectedValue) {
                        if (newlySelectedValue != null) {
                          viewController.changeProgressTime(newlySelectedValue);
                        }
                      },
                      value: viewController.selectedProgressTime,
                      underline: SizedBox(),
                      isExpanded: false,
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 8.0),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: 15,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return buildProgressItem();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 12.0,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container buildProgressItem() {
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 8.0,
                animation: false,
                percent: 0.6,
                center: Text(
                  "60.0%",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: colorAccent.withOpacity(0.7),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: colorAccent,
                backgroundColor: colorAccent.withOpacity(0.1),
              ),
            ],
          ).marginOnly(bottom: 12.0),
          Text(
            "97 Points",
            style: textStyleSectionTitle.copyWith(
              fontSize: 18.0,
            ),
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Biology Treatment Care",
            style: textStyleCaption1.copyWith(
              color: colorTextRegular,
            ),
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ).marginOnly(top: 4.0),
        ],
      ),
      decoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(16.0),
        ),
        border: const Border.fromBorderSide(
          const BorderSide(color: colorInputFieldBorder),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
    );
  }

  Container buildImprovementItem() {
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "+ 13%",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: colorAccent,
                ),
              ),
              Text(
                "3rd",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: colorTextTertiary,
                ),
              ),
            ],
          ).marginOnly(bottom: 4.0),
          Container(
            height: 80,
            child: charts.TimeSeriesChart(
              _createSampleData(),
              animate: false,
              primaryMeasureAxis: const charts.NumericAxisSpec(
                renderSpec: const charts.NoneRenderSpec(),
                showAxisLine: false,
              ),
              domainAxis: const charts.DateTimeAxisSpec(
                showAxisLine: false,
                renderSpec: const charts.NoneRenderSpec(),
              ),
              dateTimeFactory: const charts.LocalDateTimeFactory(),
            ),
          ).marginOnly(bottom: 0.0),
          Row(
            children: [
              Text(
                "73",
                style: textStyleSectionTitle.copyWith(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                " / 100",
                style: textStyleSectionTitle.copyWith(
                  color: colorTextSecondary,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          Text(
            "English Vocabulary Test",
            style: textStyleCaption1.copyWith(
              color: colorTextRegular,
            ),
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ).marginOnly(
            top: 4.0,
            bottom: 8.0,
          ),
          Row(
            children: [
              Image.asset(
                'images/ic_user_enrolled.png',
                fit: BoxFit.fitHeight,
                color: colorTextSecondary,
                height: 16.0,
              ).marginOnly(right: 8.0),
              Text(
                "100 Enrolled",
                style: textStyleCaption1.copyWith(
                  color: colorTextRegular.withOpacity(0.7),
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
      decoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(16.0),
        ),
        border: const Border.fromBorderSide(
          const BorderSide(color: colorInputFieldBorder),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
    );
  }

  Widget buildImprovementSection() {
    return GetBuilder<PracticeWrapperController>(
      init: PracticeWrapperController(),
      builder: (viewController) {
        return InkWell(
          onTap: () {
            Get.to(() => ImprovementPage());
          },
          child: Container(
            margin: const EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              right: 16.0,
              bottom: 56.0,
            ),
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
              top: 4.0,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Improvement',
                      style: textStyleSectionTitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    DropdownButton<String>(
                      icon: Image.asset(
                        'images/ic_dropdown_arrow.png',
                        fit: BoxFit.fitHeight,
                        height: 20.0,
                      ),
                      style: textStylePopupMenuTitle,
                      items: <String>["This Month", "This Year"].map(
                        (String dropdownItem) {
                          return DropdownMenuItem<String>(
                            value: dropdownItem,
                            child: Text(dropdownItem),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newlySelectedValue) {
                        if (newlySelectedValue != null) {
                          viewController
                              .changeImprovementTime(newlySelectedValue);
                        }
                      },
                      value: viewController.selectedImprovementTime,
                      underline: SizedBox(),
                      isExpanded: false,
                    ),
                  ],
                ),
                Container(
                  height: 250,
                  margin: const EdgeInsets.only(top: 8.0),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: 15,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return buildImprovementItem();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 12.0,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded buildExamType(
    String imagePath,
    String title,
    GestureTapCallback onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: colorItemInactiveBackground,
            borderRadius: const BorderRadius.all(
              const Radius.circular(16.0),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.fitHeight,
                height: 60,
              ).marginOnly(right: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: textStyleSectionTitle.copyWith(
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
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
