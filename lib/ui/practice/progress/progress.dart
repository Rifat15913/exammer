import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/practice/progress/progress_controller.dart';
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
          brightness: Brightness.light,
          leadingWidth: 64.0,
          leading: IconButton(
            icon: buildBackButton(null),
            onPressed: () => Get.back(),
          ).marginOnly(left: 8.0),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            Center(
              child: Text(
                "Suggested Courses",
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
                        buildBanner(viewController),
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

  Container buildBanner(ProgressController viewController) {
    return Container(
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: colorAccent,
        borderRadius: const BorderRadius.all(
          const Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          Text(
            "English Vocabulary Test",
            style: textStyleHoodTitle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ).marginOnly(top: 8.0),
          Divider(
            color: Colors.white.withOpacity(0.3),
          ).marginOnly(top: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "129 of 150 Points",
                style: textStyleHoodTitle.copyWith(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              DropdownButton<String>(
                dropdownColor: Colors.black,
                icon: Image.asset(
                  'images/ic_dropdown_arrow.png',
                  fit: BoxFit.fitHeight,
                  height: 20.0,
                  color: Colors.white,
                ),
                style: textStylePopupMenuTitle.copyWith(
                  color: Colors.white,
                ),
                items: <String>["This Month", "This Year"].map(
                  (String dropdownItem) {
                    return DropdownMenuItem<String>(
                      value: dropdownItem,
                      child: Text(dropdownItem),
                    );
                  },
                ).toList(),
                onChanged: (String? newlySelectedValue) {
                  if (newlySelectedValue != null) {
                    viewController.changeSubject(newlySelectedValue);
                  }
                },
                value: viewController.selectedTime,
                underline: SizedBox(),
                isExpanded: false,
              ),
            ],
          ),
        ],
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
            child: Text(
              "Total",
              style: textStyleAppBar.copyWith(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(
            "55",
            style: textStylePageTitle.copyWith(
              color: colorAccent,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            " / 75",
            style: textStylePageTitle.copyWith(
              color: colorTextSecondary,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ).marginAll(16.0),
    );
  }

  Widget buildSegment() {
    return GetBuilder<ProgressController>(
      id: "list_view_progress_items",
      init: ProgressController(),
      builder: (viewController) {
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
            itemCount: 50,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return buildItem(index);
            },
          ),
        ).marginAll(16.0);
      },
    );
  }

  Widget buildItem(int index) {
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
                      "Short Exam",
                      style: textStyleSectionItemTitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ).marginOnly(bottom: 4.0),
                    Text(
                      "21 Jul, 2020",
                      style: textStyleCaption1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                "55",
                style: textStylePageTitle.copyWith(
                  color: colorAccent,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                " / 75",
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
