import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/referral/invite/referral_invite_controller.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReferralInvitePage extends StatelessWidget {
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
        body: GetBuilder<ReferralInviteController>(
          init: ReferralInviteController(),
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
          buildMiddleSection(),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorTextSecondary.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "https://bit.ly/3qnrUr7",
                    style: TextStyle(
                      color: colorTextSecondary,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).paddingSymmetric(
                    horizontal: 16.0,
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        ToastUtil.show("Copied to clipboard");
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: colorTextSecondary.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                        ),
                        child: Center(
                          child: Text(
                            "Copy",
                            style: TextStyle(
                              color: colorTextTertiary,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: colorTextSecondary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 56.0,
                ),
                child: Text(
                  "Or Share via",
                  style: TextStyle(
                    color: colorTextSecondary,
                    fontSize: 14.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Expanded(
                child: Divider(
                  color: colorTextSecondary,
                ),
              ),
            ],
          ).marginSymmetric(vertical: 24.0),
          buildFilledButton(
            title: "Share",
            onPressCallback: () {},
            padding: const EdgeInsets.only(
              left: 0.0,
              right: 0.0,
            ),
          ),
        ],
      ),
    );
  }

  Container buildMiddleSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
              GetBuilder<ReferralInviteController>(
                id: "dropdown_button_time_period",
                init: ReferralInviteController(),
                builder: (ReferralInviteController viewController) {
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

  Container buildBottomSection() {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "How it works",
            style: textStyleSectionTitle,
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          buildInstructionItem(
            imagePath: "images/ic_share_referral_code.png",
            title: "Share your referral code",
            subtitle: "Your friends got 20% off with your code.",
          ),
          buildInstructionItem(
            imagePath: "images/ic_cash_rewards.png",
            title: "Earn cash rewards",
            subtitle:
                "You get 20% of subscription fee up to \$300 as cash rewards in a month.",
          ),
          buildInstructionItem(
            imagePath: "images/ic_cash_in_bank.png",
            title: "Get cash in your bank",
            subtitle:
                "We send all your cash rewards to your bank once every two months.",
          ),
        ],
      ),
    );
  }

  Widget buildInstructionItem({
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.fitHeight,
          height: 32.0,
        ).marginOnly(right: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyleRegularBody.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).marginOnly(bottom: 4.0),
              Text(
                subtitle,
                style: textStyleRegularBody.copyWith(
                  color: colorTextTertiary,
                  height: 1.72,
                ),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ).paddingOnly(top: 24.0);
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
