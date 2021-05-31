import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/quiz/progress/progress_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Scores",
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
        body: GetBuilder<ProgressController>(
          init: ProgressController(),
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
    return GetBuilder<ProgressController>(
      id: "list_view_progress_items",
      init: ProgressController(),
      builder: (viewController) {
        return StreamBuilder(
          stream: viewController.resultRef.onValue,
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.hasData) {
              final List<dynamic> list = [];
              (snapshot.data as Event).snapshot.value.forEach(
                (key, value) {
                  list.add(value);
                },
              );

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
                  itemCount: list.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final value = list[index];
                    return buildItem(index, value);
                  },
                ),
              ).marginAll(16.0);
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }

  Widget buildItem(int index, value) {
    return GetBuilder<ProgressController>(
      init: ProgressController(),
      builder: (viewController) {
        return InkWell(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (value as Map)["quiz_name"],
                      style: textStyleSectionItemTitle.copyWith(
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ).marginOnly(bottom: 4.0),
                    Text(
                      value["user_email"],
                      style: textStyleCaption1.copyWith(
                        color: colorAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ).marginOnly(bottom: 4.0),
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(value["created_at"])
                          .toString(),
                      style: textStyleCaption1,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                "${value["right"]}",
                style: textStylePageTitle.copyWith(
                  color: colorAccent,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                " / ${value["total"]}",
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
        );
      },
    );
  }
}
