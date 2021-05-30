import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/category/competition_category_controller.dart';
import 'package:exammer/ui/competition/challenge/challenge_competition.dart';
import 'package:exammer/ui/competition/demand/demand_competition.dart';
import 'package:exammer/ui/competition/tekka/tekka_competition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CompetitionCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        body: GetBuilder<CompetitionCategoryController>(
          init: CompetitionCategoryController(),
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
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                buildBannerSegment(),
                                buildCompetitionSegment(),
                                SizedBox(height: 56),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
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

  Widget buildCompetitionSegment() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          const Radius.circular(20.0),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Competition",
            style: textStyleSectionTitle,
          ).marginOnly(bottom: 24.0),
          ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return buildCompetitionItem(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16.0,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildCompetitionItem(int index) {
    Widget? route;

    switch (index) {
      case 0:
        route = TekkaCompetitionPage();
        break;
      case 1:
        route = DemandCompetitionPage();
        break;
      case 2:
        route = ChallengeCompetitionPage();
        break;

      default:
        break;
    }

    return InkWell(
      onTap: () {
        if (route != null) {
          Get.to(() => route);
        }
      },
      child: Container(
        width: double.infinity,
        height: 140.0,
        decoration: const BoxDecoration(
          color: colorItemInactiveBackground,
          borderRadius: const BorderRadius.all(
            const Radius.circular(14.0),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              "images/ic_cup.png",
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Tekka Competition",
                      style: textStyleHoodTitle.copyWith(
                        color: colorPrimary,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).marginOnly(bottom: 4.0),
                    Text(
                      "Get 1000 credits for each friend after they make their first purchase",
                      style: textStyleRegularBody,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
