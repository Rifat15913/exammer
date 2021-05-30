import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/wallet/add_balance/add_balance.dart';
import 'package:exammer/ui/wallet/my_account/my_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyAccountPage extends StatelessWidget {
  final currencyFormatter =
      charts.BasicNumericTickFormatterSpec.fromNumberFormat(
    NumberFormat.compactSimpleCurrency(),
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "My Account",
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
        body: GetBuilder<MyAccountController>(
          init: MyAccountController(),
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
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
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
            "Statistics",
            style: textStyleSectionTitle,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ).marginOnly(bottom: 16.0),
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildStatisticsItem(
                    title: "\$17.45",
                    caption: "Balance",
                    baseColor: colorAccent,
                  ),
                  buildStatisticsItem(
                    title: "\$284.97",
                    caption: "Expenses",
                    baseColor: colorOrange,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30.0),
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    "images/ic_wallet.png",
                    fit: BoxFit.contain,
                    width: 24.0,
                    height: 24.0,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: colorTextSecondary,
            height: 1,
          ).marginSymmetric(vertical: 24.0),
          buildFilledButton(
            title: "Add Balance",
            onPressCallback: () {
              Get.to(() => AddBalancePage());
            },
            padding: const EdgeInsets.only(
              left: 0.0,
              right: 0.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatisticsItem({
    required String title,
    required String caption,
    required Color baseColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            color: baseColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              title,
              style: textStyleStatisticsBody,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: baseColor,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              caption,
              style: textStyleStatisticsCaption,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }

  Container buildBottomSection() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Referral income",
                style: textStyleSectionTitle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              GetBuilder<MyAccountController>(
                id: "dropdown_button_time_period",
                init: MyAccountController(),
                builder: (MyAccountController viewController) {
                  return DropdownButton<String>(
                    icon: Image.asset(
                      'images/ic_dropdown_arrow.png',
                      fit: BoxFit.fitHeight,
                      height: 20.0,
                    ),
                    style: textStylePopupMenuTitle,
                    items: <String>["Last week", "Last month", "Last year"].map(
                      (String dropdownItem) {
                        return DropdownMenuItem<String>(
                          value: dropdownItem,
                          child: Text(dropdownItem),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newlySelectedValue) {
                      if (newlySelectedValue != null) {
                        viewController.changeTimePeriod(newlySelectedValue);
                      }
                    },
                    value: viewController.selectedTimePeriod,
                    underline: SizedBox(),
                    isExpanded: false,
                  );
                },
              ),
            ],
          ).marginOnly(bottom: 8.0),
          Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 24.0),
            padding: const EdgeInsets.only(
              left: 6.0,
            ),
            child: charts.TimeSeriesChart(
              _createSampleData(),
              animate: false,
              // Set the default renderer to a bar renderer.
              // This can also be one of the custom renderers of the time series chart.
              defaultRenderer: new charts.BarRendererConfig<DateTime>(),
              // It is recommended that default interactions be turned off if using bar
              // renderer, because the line point highlighter is the default for time
              // series chart.
              defaultInteractions: false,
              // If default interactions were removed, optionally add select nearest
              // and the domain highlighter that are typical for bar charts.
              behaviors: [
                charts.SelectNearest(),
                charts.DomainHighlighter(),
              ],
              // Assign a custom style for the measure axis.
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickFormatterSpec: currencyFormatter,
              ),
              // Optionally pass in a [DateTimeFactory] used by the chart. The factory
              // should create the same type of [DateTime] as the data provided. If none
              // specified, the default creates local date time.
              dateTimeFactory: const charts.LocalDateTimeFactory(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$2,648.00",
                style: const TextStyle(
                  color: colorTextRegular,
                  fontSize: 32.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.1875,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                children: [
                  Image.asset(
                    "images/ic_up_arrow.png",
                    fit: BoxFit.fitHeight,
                    height: 22.0,
                  ).marginOnly(right: 4.0),
                  Text(
                    "Level 2",
                    style: const TextStyle(
                      color: colorAccent,
                      fontSize: 16.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.375,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ).marginOnly(
            bottom: 16.0,
            left: 6.0,
            right: 6.0,
          ),
          Text(
            "75% to complete",
            style: textStyleSectionTitle.copyWith(
              height: 1.625,
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ).marginOnly(
            bottom: 8.0,
            left: 6.0,
            right: 6.0,
          ),
          LinearPercentIndicator(
            lineHeight: 8.0,
            percent: 0.25,
            progressColor: colorAccent,
            backgroundColor: colorItemInactiveBackground,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Level 1",
                style: textStyleCaption1.copyWith(
                  color: colorTextTertiary,
                  height: 1.5,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "Level 2",
                style: textStyleCaption1.copyWith(
                  color: colorTextTertiary,
                  height: 1.5,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ).marginOnly(
            left: 6.0,
            right: 6.0,
            top: 8.0,
          ),
          buildFilledButton(
            title: "Cash Out",
            onPressCallback: () {},
            padding: EdgeInsets.zero,
          ).marginOnly(top: 16.0),
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
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
