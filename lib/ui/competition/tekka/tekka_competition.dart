import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/tekka/tekka_competition_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TekkaCompetitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Tekka Competition",
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
        body: GetBuilder<TekkaCompetitionController>(
          init: TekkaCompetitionController(),
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
    return GetBuilder<TekkaCompetitionController>(
      init: TekkaCompetitionController(),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: const BoxDecoration(
                    color: colorItemInactiveBackground,
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  margin: const EdgeInsets.only(right: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Center(
                    child: Text(
                      "07",
                      style: textStylePageTitle.copyWith(
                        fontSize: 16.0,
                        color: colorAccent,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Daily Competition",
                    style: textStyleHoodTitle.copyWith(
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Text(
              "Get 1000 credits for each friend after they make their first purchase",
              style: textStylePageSubtitle,
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ).marginSymmetric(vertical: 12.0),
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
                "Register Now",
                style: textStyleFilledButton.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
