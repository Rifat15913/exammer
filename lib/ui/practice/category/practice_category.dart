import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/practice/category/practice_category_controller.dart';
import 'package:exammer/ui/practice/subcategory/practice_subcategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PracticeCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Short Exam",
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
        body: GetBuilder<PracticeCategoryController>(
          init: PracticeCategoryController(),
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
    return GetBuilder<PracticeCategoryController>(
      id: "list_view_practice_category",
      init: PracticeCategoryController(),
      builder: (viewController) {
        return Container(
          decoration: boxDecorationSectionCardBackground,
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            controller: viewController.scrollController,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: SizedBox(
                height: 1.0,
              ),
            ),
            itemCount: 50,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return buildItem();
            },
          ),
        ).marginAll(16.0);
      },
    );
  }

  Widget buildItem() {
    return InkWell(
      onTap: () {
        Get.to(() => PracticeSubcategoryPage());
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            const Radius.circular(16.0),
          ),
          border: const Border.fromBorderSide(
            const BorderSide(color: colorInputFieldBorder),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: colorItemInactiveBackground,
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.music_note,
                size: 24.0,
                color: colorAccent,
              ),
            ).marginOnly(right: 16.0),
            Expanded(
              flex: 3,
              child: Text(
                "Instrumental Music – specific instrument",
                style: textStyleSectionItemTitle.copyWith(
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                "34 Courses",
                style: textStyleSectionItemTitle.copyWith(
                  color: colorTextSecondary,
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
