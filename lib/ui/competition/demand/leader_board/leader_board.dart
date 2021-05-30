import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/demand/leader_board/leader_board_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LeaderBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Leaderboard",
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
        body: GetBuilder<LeaderBoardController>(
          init: LeaderBoardController(),
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
                        buildBottomSection(),
                      ],
                    ),
                  );
          },
        ),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 16.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "194",
              style: textStyleRegularBody,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 16,
            backgroundImage: NetworkImage(
              "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
            ),
          ).marginSymmetric(horizontal: 12.0),
          Expanded(
            flex: 5,
            child: Text(
              "Mahmudul Hasan",
              style: textStyleSectionItemTitle,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Expanded(
            child: Text(
              "48",
              style: textStyleSectionItemTitle.copyWith(
                color: colorAccent,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "23.47m",
              style: textStyleHoodSubtitle,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return GetBuilder<LeaderBoardController>(
      id: "list_view_progress_items",
      init: LeaderBoardController(),
      builder: (viewController) {
        return Container(
          decoration: boxDecorationSectionCardBackground,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "No",
                        style: textStyleListHeader,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      height: 32,
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        "Name",
                        style: textStyleListHeader,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Point",
                        style: textStyleListHeader,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Time",
                        style: textStyleListHeader,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1.0,
                color: colorTextSecondary,
              ),
              Expanded(
                child: ListView.separated(
                  controller: viewController.scrollController,
                  separatorBuilder: (context, index) => Divider(
                    height: 1.0,
                    color: colorTextSecondary,
                  ),
                  itemCount: 50,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return buildItem(index);
                  },
                ),
              ),
            ],
          ),
        ).marginAll(16.0);
      },
    );
  }

  Widget buildItem(int index) {
    return GetBuilder<LeaderBoardController>(
      init: LeaderBoardController(),
      builder: (viewController) {
        return InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "194",
                    style: textStyleRegularBody,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  backgroundImage: NetworkImage(
                    "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                  ),
                ).marginSymmetric(horizontal: 12.0),
                Expanded(
                  flex: 5,
                  child: Text(
                    "Mahmudul Hasan",
                    style: textStyleSectionItemTitle,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: Text(
                    "48",
                    style: textStyleSectionItemTitle.copyWith(
                      color: colorAccent,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "23.47m",
                    style: textStyleHoodSubtitle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
