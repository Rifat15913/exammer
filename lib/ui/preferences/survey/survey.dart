import 'dart:collection';

import 'package:exammer/base/widget/central_empty_list_placeholder.dart';
import 'package:exammer/base/widget/central_error_placeholder.dart';
import 'package:exammer/base/widget/central_progress_indicator.dart';
import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/repository/remote_repository.dart';
import 'package:exammer/data/remote/response/get_survey_data_response.dart';
import 'package:exammer/ui/preferences/survey/survey_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leadingWidth: 64,
          brightness: Brightness.light,
          leading: IconButton(
            icon: buildBackButton(null),
            onPressed: () => Get.back(result: true),
          ).marginOnly(left: 8.0),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: GetBuilder<SurveyController>(
          id: "body",
          init: SurveyController(),
          builder: (viewController) {
            return viewController.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: FutureBuilder<GetSurveyDataResponse>(
                      future: RemoteRepository.on().getSurveyData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              buildContainerTopHood(),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      buildCategorySection(
                                        snapshot.data!,
                                      ),
                                      buildTimeLengthSection(
                                        snapshot.data!.timeLengthList,
                                      ),
                                      buildProfessionSection(
                                        snapshot.data!.professionList,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24.0),
                                    topRight: Radius.circular(24.0),
                                  ),
                                ),
                                child: buildFilledButton(
                                  onPressCallback: () {
                                    viewController.finishSurvey();
                                  },
                                  backgroundColor: colorPrimary,
                                  title: 'done'.tr,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0,
                                    vertical: 24.0,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return CentralErrorPlaceholder(
                            message: "${snapshot.error}",
                          );
                        }

                        return const CentralProgressIndicator();
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildCategorySection(GetSurveyDataResponse data) {
    final list = data.trainingCategoryList.data;
    final icon = data.trainingCategoryIcon;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: list.isEmpty
            ? const CentralEmptyListPlaceholder()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'survey_top_title'.tr,
                    style: textStyleSectionTitle,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      height: 160,
                      child: GetBuilder<SurveyController>(
                        id: "list_view_top_section",
                        init: SurveyController(),
                        builder: (viewController) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            itemCount: list.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              final item = list[index];

                              return InkWell(
                                onTap: () {
                                  final id = item.id;
                                  final controller = viewController;

                                  if (controller.selectedTrainingIdMap
                                          .containsKey(id) &&
                                      controller.selectedTrainingIdMap[id]!) {
                                    controller.deselectItemFromTopSection(id);
                                  } else {
                                    controller.selectItemFromTopSection(id);
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: colorItemInactiveBackground,
                                          border: Border.all(
                                            color: getBorderColor(
                                              viewController,
                                              item.id,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.network(
                                            icon,
                                            fit: BoxFit.cover,
                                            height: 80.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        item.name,
                                        style: textStyleSectionItemTitle,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) {
                              return SizedBox(
                                width: 12.0,
                              );
                            },
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

  Color getBorderColor(SurveyController controller, int id) {
    return (controller.selectedTrainingIdMap.containsKey(id) &&
            controller.selectedTrainingIdMap[id]!)
        ? colorItemActiveBackground
        : colorItemInactiveBackground;
  }

  Widget buildTimeLengthSection(HashMap<String, String> timeLengthList) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'survey_middle_title'.tr,
                style: textStyleSectionTitle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            GetBuilder<SurveyController>(
              id: "chips_preparation_time",
              init: SurveyController(),
              builder: (surveyController) {
                return Wrap(
                  children: buildPreparationTimeList(
                    surveyController,
                    timeLengthList,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildPreparationTimeList(
    SurveyController surveyController,
    HashMap<String, String> timeLengthList,
  ) {
    List<Widget> list = [];

    for (int i = 0; i < timeLengthList.length; i++) {
      bool isSelected =
          surveyController.selectedIndexMap.containsKey(keyMiddle) &&
              surveyController.selectedIndexMap[keyMiddle] == i;

      final key = timeLengthList.keys.elementAt(i);
      final timePeriod = timeLengthList[key]!;

      list.add(
        Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            bottom: 8.0,
          ),
          child: ChoiceChip(
            label: Text(
              timePeriod,
              style: TextStyle(
                color: isSelected ? Colors.white : colorPrimary,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            padding: const EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: colorItemInactiveBackground,
            selectedColor: colorItemActiveBackground,
            selected: isSelected,
            onSelected: (bool selected) {
              if (selected) {
                surveyController.selectItemFromMiddleSection(i, timePeriod);
              } else {
                surveyController.deselectItemFromMiddleSection();
              }
            },
          ),
        ),
      );
    }

    return list;
  }

  Widget buildProfessionSection(HashMap<String, String> professionList) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'survey_bottom_title'.tr,
                style: textStyleSectionTitle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            GetBuilder<SurveyController>(
              id: "chips_current_work",
              init: SurveyController(),
              builder: (surveyController) {
                return Wrap(
                  children: buildCurrentWorkList(
                    surveyController,
                    professionList,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildCurrentWorkList(
    SurveyController surveyController,
    HashMap<String, String> professionList,
  ) {
    List<Widget> list = [];

    for (int i = 0; i < professionList.length; i++) {
      bool isSelected =
          surveyController.selectedIndexMap.containsKey(keyBottom) &&
              surveyController.selectedIndexMap[keyBottom] == i;

      final key = professionList.keys.elementAt(i);
      final profession = professionList[key]!;

      list.add(
        Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            bottom: 8.0,
          ),
          child: ChoiceChip(
            label: Text(
              profession,
              style: TextStyle(
                color: isSelected ? Colors.white : colorPrimary,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            padding: const EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: colorItemInactiveBackground,
            selectedColor: colorItemActiveBackground,
            selected: isSelected,
            onSelected: (bool selected) {
              if (selected) {
                surveyController.selectItemFromBottomSection(i, profession);
              } else {
                surveyController.deselectItemFromBottomSection();
              }
            },
          ),
        ),
      );
    }

    return list;
  }
}
