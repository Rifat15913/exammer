import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/job/view/job_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class JobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        body: GetBuilder<JobController>(
          init: JobController(),
          builder: (controller) {
            if (controller.isLoading) {
              return centralProgressIndicator;
            } else {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildContainerTopHood(),
                    Expanded(
                      child: buildSection(),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildSection() {
    return GetBuilder<JobController>(
      id: "job_section",
      init: JobController(),
      builder: (viewController) {
        return Container(
          margin: const EdgeInsets.only(
            left: 16.0,
            top: 16.0,
            right: 16.0,
            bottom: 56.0,
          ),
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Find Your Jobs',
                      style: textStyleSectionTitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showPopup();
                    },
                    child: Image.asset(
                      "images/ic_filter.png",
                      height: 24.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (!viewController.isPartTime) {
                          viewController.toggleJobType();
                        }
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "Part time",
                            style: textStyleSectionSubtitle.copyWith(
                              color: viewController.isPartTime
                                  ? Colors.white
                                  : colorTextTertiary,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: viewController.isPartTime
                              ? colorAccent
                              : colorTextSecondary.withOpacity(0.15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (viewController.isPartTime) {
                          viewController.toggleJobType();
                        }
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "Full time",
                            style: textStyleSectionSubtitle.copyWith(
                              color: !viewController.isPartTime
                                  ? Colors.white
                                  : colorTextTertiary,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: !viewController.isPartTime
                              ? colorAccent
                              : colorTextSecondary.withOpacity(0.15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ).marginSymmetric(vertical: 16.0),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  itemCount: 20,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return buildItem();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 16.0,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container buildItem() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                child: Image.network(
                  'https://tinyurl.com/57s3d6c5',
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
              ).marginOnly(right: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Custom Data Retriever",
                      style: textStyleSectionTitle.copyWith(
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ).marginOnly(bottom: 2.0),
                    Text(
                      "Ajker deal",
                      style: textStyleHoodSubtitle.copyWith(
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'images/ic_location_pin.png',
                    height: 12.0,
                    color: colorTextSecondary,
                  ).marginOnly(right: 4.0),
                  Text(
                    "Dhaka, Bangladesh",
                    style: textStyleInputFormHint,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              Text(
                "\$60/h",
                style: textStyleAppBar.copyWith(
                  fontSize: 14.0,
                  color: colorAccent,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ).marginOnly(top: 16.0),
          Divider(
            color: colorTextSecondary.withOpacity(0.5),
          ).marginSymmetric(vertical: 4.0),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  padding: const EdgeInsets.all(12.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(6.0),
                    ),
                  ),
                  onPressed: () {},
                  color: colorAccent,
                  child: Text(
                    "View Job",
                    style: textStyleFilledButton.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: FlatButton(
                  padding: const EdgeInsets.all(12.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(6.0),
                    ),
                    side: BorderSide(color: colorTextSecondary),
                  ),
                  onPressed: () {},
                  color: Colors.white,
                  child: Text(
                    "Start Course",
                    style: textStyleFilledButton.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: colorTextSecondary,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: colorTextSecondary.withOpacity(0.15),
        borderRadius: const BorderRadius.all(
          const Radius.circular(14.0),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
    );
  }

  void showPopup() {
    if (Get.context != null) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ), //this right here
            child: Container(
              height: 500,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 16.0,
              ),
              child: GetBuilder<JobController>(
                id: "dialog_filter",
                init: JobController(),
                builder: (JobController viewController) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Image.asset(
                                'images/ic_close.png',
                                fit: BoxFit.fitHeight,
                                height: 24.0,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            "Job Filter",
                            style: TextStyle(
                              color: colorTextRegular,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ).marginOnly(
                          top: 16.0,
                          bottom: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildJobFilterPeriod(
                              () {
                                viewController.toggleFilterPeriod(
                                  viewController.selectedPeriod == 1 ? -1 : 1,
                                );
                              },
                              viewController.selectedPeriod == 1,
                              "Today",
                            ),
                            SizedBox(width: 8.0),
                            buildJobFilterPeriod(
                              () {
                                viewController.toggleFilterPeriod(
                                  viewController.selectedPeriod == 2 ? -1 : 2,
                                );
                              },
                              viewController.selectedPeriod == 2,
                              "This Week",
                            ),
                            SizedBox(width: 8.0),
                            buildJobFilterPeriod(
                              () {
                                viewController.toggleFilterPeriod(
                                  viewController.selectedPeriod == 3 ? -1 : 3,
                                );
                              },
                              viewController.selectedPeriod == 3,
                              "This Month",
                            ),
                          ],
                        ),
                        Container(
                          decoration: boxDecorationBorderForm,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          margin:
                              const EdgeInsets.only(top: 24.0, bottom: 16.0),
                          child: DropdownButton<String>(
                            icon: Image.asset(
                              'images/ic_dropdown_arrow.png',
                              fit: BoxFit.fitHeight,
                              height: 20.0,
                            ),
                            style: textStylePopupMenuTitle.copyWith(
                              color: colorTextSecondary,
                            ),
                            items: <String>[
                              "Experience 1",
                              "Experience 2",
                              "Experience 3"
                            ].map(
                              (String dropdownItem) {
                                return DropdownMenuItem<String>(
                                  value: dropdownItem,
                                  child: Text(dropdownItem),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newlySelectedValue) {
                              if (newlySelectedValue != null) {
                                viewController
                                    .changeExperience(newlySelectedValue);
                              }
                            },
                            value: viewController.selectedExperience,
                            underline: SizedBox(),
                            isExpanded: true,
                          ),
                        ),
                        Container(
                          decoration: boxDecorationBorderForm,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DropdownButton<String>(
                            icon: Image.asset(
                              'images/ic_dropdown_arrow.png',
                              fit: BoxFit.fitHeight,
                              height: 20.0,
                            ),
                            style: textStylePopupMenuTitle.copyWith(
                              color: colorTextSecondary,
                            ),
                            items: <String>[
                              "Category 1",
                              "Category 2",
                              "Category 3"
                            ].map(
                              (String dropdownItem) {
                                return DropdownMenuItem<String>(
                                  value: dropdownItem,
                                  child: Text(dropdownItem),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newlySelectedValue) {
                              if (newlySelectedValue != null) {
                                viewController
                                    .changeCategory(newlySelectedValue);
                              }
                            },
                            value: viewController.selectedCategory,
                            underline: SizedBox(),
                            isExpanded: true,
                          ),
                        ),
                        Container(
                          decoration: boxDecorationBorderForm,
                          padding: const EdgeInsets.only(left: 16.0),
                          margin:
                              const EdgeInsets.only(top: 16.0, bottom: 32.0),
                          child: TextFormField(
                            obscureText: false,
                            style: textStyleInputForm,
                            keyboardType: TextInputType.streetAddress,
                            decoration: inputDecorationForm.copyWith(
                              hintText: "Location",
                              suffixIcon: UnconstrainedBox(
                                child: Image.asset(
                                  'images/ic_location_pin.png',
                                  height: 20.0,
                                ),
                              ),
                            ),
                            controller: viewController.locationController,
                          ),
                        ),
                        FlatButton(
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          color: colorAccent,
                          child: Text(
                            "Apply Filter",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }

  Expanded buildJobFilterPeriod(
    GestureTapCallback onTap,
    bool selectingCondition,
    String title,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Center(
            child: Text(
              title,
              style: textStyleSectionSubtitle.copyWith(
                color: selectingCondition ? Colors.white : colorTextTertiary,
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: selectingCondition
                ? colorAccent
                : colorTextSecondary.withOpacity(0.15),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
        ),
      ),
    );
  }
}
