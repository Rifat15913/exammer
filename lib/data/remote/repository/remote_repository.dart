import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/response/base_response.dart';
import 'package:exammer/data/remote/response/get_dashboard_data_response.dart';
import 'package:exammer/data/remote/response/get_survey_data_response.dart';
import 'package:exammer/data/remote/response/login_response.dart';
import 'package:exammer/util/helper/network/api.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RemoteRepository {
  RemoteRepository._internal();

  static final RemoteRepository _instance = RemoteRepository._internal();

  static RemoteRepository on() {
    if (ApiUtil.client == null) {
      ApiUtil.client = Dio(
        BaseOptions(
          baseUrl: baseApiUrl,
          headers: {
            HttpHeaders.acceptHeader: responseOfJsonType,
          },
        ),
      );

      ApiUtil.client!.interceptors.add(
        PrettyDioLogger(
          requestHeader: kDebugMode,
          requestBody: kDebugMode,
          responseBody: kDebugMode,
          responseHeader: kDebugMode,
        ),
      );
    }

    return _instance;
  }

  // Authentication
  Future<LoginResponse> login(
    String emailAddress,
    String password,
  ) async {
    final response = await ApiUtil.postRequest(
      endPoint: loginUrl,
      data: {
        keyEmail: emailAddress,
        keyPassword: password,
      },
    );

    return LoginResponse.fromJson(response.data);
  }

  Future<GetSurveyDataResponse> getSurveyData() async {
    final response = await ApiUtil.getRequest(
      endPoint: surveyUrl,
      shouldGetOtherHeaders: true,
    );

    return GetSurveyDataResponse.fromJson(response.data);
  }

  Future<BaseResponse> submitSurveyData({
    required List<int> categoryList,
    required String timeLength,
    required String profession,
  }) async {
    final response = await ApiUtil.postRequest(
      endPoint: surveyUrl,
      shouldGetOtherHeaders: true,
      data: {
        keyTrainingCategory: categoryList,
        keyTimeLength: timeLength,
        keyProfession: profession,
      },
    );

    return BaseResponse(response.data);
  }

  Future<BaseResponse> register({
    required String emailPhone,
    required String password,
  }) async {
    final response = await ApiUtil.postRequest(
      endPoint: registerUrl,
      shouldGetOtherHeaders: false,
      data: {
        keyEmail: emailPhone,
        keyPassword: password,
      },
    );

    return BaseResponse(response.data);
  }

  Future<BaseResponse> verifyRegistration({
    required String emailPhone,
    required String code,
  }) async {
    final response = await ApiUtil.postRequest(
      endPoint: verifyRegistrationUrl,
      shouldGetOtherHeaders: false,
      data: {
        keyEmail: emailPhone,
        keyVerificationCode: code,
      },
    );

    return BaseResponse(response.data);
  }

  Future<GetDashboardDataResponse> getDashboardData() async {
    final response = await ApiUtil.getRequest(
      endPoint: dashboardUrl,
      shouldGetOtherHeaders: true,
    );

    return GetDashboardDataResponse.fromJson(response.data);
  }
}
