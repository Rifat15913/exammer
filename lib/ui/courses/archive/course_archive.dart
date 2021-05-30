import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/courses/archive/course_archive_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CourseArchivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "English",
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
        body: GetBuilder<CourseArchiveController>(
          init: CourseArchiveController(),
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
                          child: buildCourseSegment(),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildCourseSegment() {
    return Container(
      decoration: boxDecorationSectionCardBackground,
      padding: const EdgeInsets.all(16.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 14,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return buildCourseItem(index);
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(2);
        },
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    ).marginAll(16.0);
  }

  Widget buildCourseItem(int index) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: shapeCardItemRectangle,
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: Image.network(
                      "https://edu.google.com/images/social_image.jpg",
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: colorAccent,
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "17 lessons",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ).marginOnly(
                    left: 8.0,
                    top: 8.0,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      index % 4 == 0
                          ? "Mathematics"
                          : "English Advance Learning Course",
                      style: textStyleRegularBody,
                      textAlign: TextAlign.start,
                      maxLines: 2,
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
                      children: [
                        Image.asset(
                          "images/ic_clock.png",
                          fit: BoxFit.cover,
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
              ).marginSymmetric(vertical: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
