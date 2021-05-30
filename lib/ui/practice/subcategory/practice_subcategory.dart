import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/practice/exam/exam.dart';
import 'package:exammer/ui/practice/subcategory/practice_subcategory_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PracticeSubcategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "English Vocabulary",
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
        body: GetBuilder<PracticeSubcategoryController>(
          init: PracticeSubcategoryController(),
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
    return GetBuilder<PracticeSubcategoryController>(
      id: "list_view_practice_subcategory",
      init: PracticeSubcategoryController(),
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
        Get.to(() => ExamPage());
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
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "Fluid Dynamics",
                style: textStyleSectionItemTitle.copyWith(
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              "105\nPoints",
              style: textStyleSectionItemTitle.copyWith(
                color: colorTextSecondary,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
