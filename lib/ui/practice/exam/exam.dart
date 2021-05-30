import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/practice/exam/exam_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Question 5 of 10",
            style: textStyleAppBar,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          brightness: Brightness.light,
          leadingWidth: 64.0,
          leading: IconButton(
            icon: buildCloseButton(null),
            onPressed: () => Get.back(),
          ).marginOnly(left: 8.0),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            Center(
              child: Text(
                "00:09",
                style: textStyleSectionSubtitle.copyWith(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ).marginOnly(right: 16.0),
          ],
        ),
        body: GetBuilder<ExamController>(
          init: ExamController(),
          builder: (controller) {
            return controller.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildTopHood(),
                        Expanded(
                          child: buildSegment(),
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
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Computer Fundamental",
                  style: textStyleAppBar,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ).marginOnly(bottom: 8.0),
                Text(
                  "25 of 32 pages",
                  style: textStyleHoodSubtitle,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colorTextSecondary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: colorAccent,
            ),
            onPressed: () {},
          ),
        ],
      ).marginAll(16.0),
    );
  }

  Container buildTopHood() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: colorTextSecondary).marginOnly(
            bottom: 8.0,
            top: 4.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/ic_coin.png',
                fit: BoxFit.fitHeight,
                height: 16.0,
              ),
              Text(
                "4",
                style: textStyleAppBar.copyWith(
                  color: colorAccent,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).marginSymmetric(horizontal: 8.0),
              Image.asset(
                'images/ic_sword.png',
                fit: BoxFit.fitHeight,
                height: 16.0,
              ),
              Text(
                "4",
                style: textStyleAppBar.copyWith(
                  color: colorAccent,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).marginSymmetric(horizontal: 8.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSegment() {
    return GetBuilder<ExamController>(
      id: "list_view_exam_items",
      init: ExamController(),
      builder: (viewController) {
        return Container(
          decoration: boxDecorationSectionCardBackground,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 34.0,
                    height: 34.0,
                    decoration: const BoxDecoration(
                      color: colorAccent,
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(6.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Q",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ).marginOnly(right: 12.0),
                  Expanded(
                    child: Text(
                      "Which one is apple brand product?",
                      style: textStylePopupMenuSubtitle.copyWith(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ).marginOnly(bottom: 24.0),
              Expanded(
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
                  itemCount: 5,
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
    return GetBuilder<ExamController>(
      init: ExamController(),
      builder: (viewController) {
        bool isSelected = (viewController.selectedIndex != null &&
            viewController.selectedIndex == index);

        return InkWell(
          onTap: () {
            viewController.selectItem(index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? colorExamItemActiveBackground
                  : colorExamItemInactiveBackground,
              borderRadius: const BorderRadius.all(
                const Radius.circular(14.0),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isSelected
                    ? Container(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    : Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorInputFieldBorder,
                            width: 2.0,
                          ),
                        ),
                      ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    "Iphone 12",
                    style: textStyleRegularBody.copyWith(
                      color: isSelected ? Colors.white : colorTextRegular,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
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
