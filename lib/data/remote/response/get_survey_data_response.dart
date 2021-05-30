import 'dart:collection';

import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/model/survey/training_category_list/training_category_list.dart';
import 'package:exammer/data/remote/response/base_response.dart';

class GetSurveyDataResponse extends BaseResponse {
  late TrainingCategoryList trainingCategoryList;
  late HashMap<String, String> timeLengthList, professionList;
  late String trainingCategoryIcon;

  GetSurveyDataResponse.fromJson(Map<String, dynamic> json) : super(json) {
    trainingCategoryList = TrainingCategoryList.fromJson(
      data[keyTrainingCategories] as Map<String, dynamic>,
    );

    timeLengthList = HashMap<String, String>();
    timeLengthList.clear();
    (data[keyTimeLengths] as Map<String, dynamic>).forEach(
      (key, value) {
        timeLengthList[key] = value as String;
      },
    );

    professionList = HashMap<String, String>();
    professionList.clear();
    (data[keyProfessions] as Map<String, dynamic>).forEach(
      (key, value) {
        professionList[key] = value as String;
      },
    );

    trainingCategoryIcon = data[keyCategoryIconUrl] as String? ?? defaultString;
  }
}
