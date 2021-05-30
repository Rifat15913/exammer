import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/demand/demand_competition_controller.dart';
import 'package:exammer/ui/competition/demand/enter_the_code/enter_the_code.dart';
import 'package:exammer/ui/competition/demand/leader_board/leader_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DemandCompetitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Demand Competition",
            style: textStyleAppBar,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          brightness: Brightness.light,
          leadingWidth: 64.0,
          leading: IconButton(
            icon: buildBackButton(null),
            onPressed: () => Get.back(result: true),
          ).marginOnly(left: 8.0),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: GetBuilder<DemandCompetitionController>(
          init: DemandCompetitionController(),
          builder: (controller) {
            return controller.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildContainerTopHood(),
                        Expanded(
                          child: buildSegment(),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildSegment() {
    return GetBuilder<DemandCompetitionController>(
      init: DemandCompetitionController(),
      builder: (viewController) {
        return Container(
          decoration: boxDecorationSectionCardBackground.copyWith(
            color: Colors.transparent,
          ),
          margin: const EdgeInsets.all(16.0),
          child: ListView.separated(
            controller: viewController.scrollController,
            separatorBuilder: (context, index) => SizedBox(
              height: 16.0,
            ),
            itemCount: 10,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return buildItem();
            },
          ),
        );
      },
    );
  }

  Widget buildItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/ic_calendar.png",
                      fit: BoxFit.fitWidth,
                      width: 24.0,
                    ).marginOnly(right: 4.0),
                    Text(
                      "12 Dec, 2020",
                      style: textStyleHoodSubtitle,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/ic_clock.png",
                      fit: BoxFit.fitWidth,
                      width: 24.0,
                    ).marginOnly(right: 4.0),
                    Text(
                      "2:30 PM - 4:00 PM",
                      style: textStyleHoodSubtitle,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ).marginOnly(bottom: 8.0),
            Text(
              "Mathematics Beginner Course",
              style: textStyleSectionTitle.copyWith(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Get 1000 credits for each friend after they make their first purchase",
              style: textStylePageSubtitle.copyWith(
                fontSize: 14.0,
              ),
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ).marginOnly(
              bottom: 12.0,
              top: 4.0,
            ),
            Row(
              children: [
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
                  onPressed: () {
                    Get.to(() => EnterTheCodePage());
                  },
                  child: Text(
                    "Enter Code",
                    style: textStyleFilledButton.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
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
                      side: const BorderSide(
                        color: colorAccent,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Get.to(() => LeaderBoardPage());
                  },
                  child: Text(
                    "Leaderboard",
                    style: textStyleFilledButton.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: colorAccent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
