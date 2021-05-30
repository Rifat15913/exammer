import 'package:exammer/base/exception/app_exception.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/data/remote/repository/remote_repository.dart';
import 'package:exammer/ui/preferences/introduction/introduction.dart';
import 'package:exammer/util/helper/keyboard.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:exammer/util/lib/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController {
  late TextEditingController codeController;
  late bool isLoading;
  String? _emailPhone;

  @override
  void onInit() {
    codeController = TextEditingController();
    isLoading = false;
    super.onInit();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  bool _validateData() {
    if (Get.context != null) {
      KeyboardUtil.hideKeyboard(Get.context!);
    }

    if (!TextUtil.isNotEmpty(codeController.text)) {
      ToastUtil.show('fill_up_the_field'.tr);
      return false;
    } else if (!TextUtil.isNotEmpty(_emailPhone)) {
      ToastUtil.show('handle_not_found'.tr);
      return false;
    } else if (!RegExp(regularExpressionEmail).hasMatch(
      _emailPhone!,
    )) {
      ToastUtil.show('invalid_email'.tr);
      return false;
    } else if (!RegExp(regularExpressionPhone).hasMatch(
      _emailPhone!,
    )) {
      ToastUtil.show('invalid_phone'.tr);
      return false;
    } else if (codeController.text.trim().length !=
        minimumVerificationCodeLength) {
      ToastUtil.show('code_length_required'.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<void> verify({required String emailPhone}) async {
    this._emailPhone = emailPhone;
    if (_validateData()) {
      isLoading = true;
      update(["body"]);

      try {
        final response = await RemoteRepository.on().verifyRegistration(
          emailPhone: _emailPhone!,
          code: codeController.text.trim(),
        );

        if (response.isSuccessful) {
          codeController.clear();
          Get.offAll(() => IntroductionPage());
        } else {
          if (TextUtil.isNotEmpty(response.message)) {
            ToastUtil.show(response.message);
          } else {
            ToastUtil.show('verification_error'.tr);
          }
        }

        isLoading = false;
        update(["body"]);
      } catch (e) {
        if (e is AppException) {
          ToastUtil.show(e.toString());
        } else {
          ToastUtil.show('verification_error'.tr);
        }

        isLoading = false;
        update(["body"]);
      }
    }
  }
}
