import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/courses/archive/course_archive.dart';
import 'package:exammer/ui/courses/portal/course_portal_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CoursePortalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        body: GetBuilder<CoursePortalController>(
          init: CoursePortalController(),
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
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                buildCourseSegment(),
                                buildCourseSegment(),
                                buildCourseSegment(),
                                buildCourseSegment(),
                                buildCourseSegment(
                                  shouldSetPaddingAtBottom: true,
                                ),
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

  Widget buildCourseSegment({
    bool shouldShowSeeAll = true,
    bool shouldSetPaddingAtBottom = false,
  }) {
    return Padding(
      padding: shouldSetPaddingAtBottom
          ? const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              bottom: 56.0,
            )
          : const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Trending Courses',
                    style: textStyleSectionTitle,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if (shouldShowSeeAll)
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CourseArchivePage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'see_all'.tr,
                        style: textStyleSectionSubtitle,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                height: 260,
                child: ListView.separated(
                  physics: PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: 50,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return buildCourseItem();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 12.0,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseItem() {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: shapeCardItemRectangle,
        child: Container(
          width: 200,
          child: Column(
            children: [
              ClipRRect(
                child: Image.network(
                  "https://edu.google.com/images/social_image.jpg",
                  fit: BoxFit.cover,
                  height: 150,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "English Advance Learning Course",
                        style: textStyleRegularBody,
                        textAlign: TextAlign.start,
                        maxLines: 3,
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "images/ic_lesson.png",
                                fit: BoxFit.fitHeight,
                                height: 24,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  "17 lessons",
                                  style: textStyleSmallestBody,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                  "images/ic_clock.png",
                                  fit: BoxFit.fitHeight,
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
