import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/profile/change_password/change_password_controller.dart';
import 'package:exammer/ui/profile/edit/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Change Password",
            style: textStyleAppBar,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          brightness: Brightness.light,
          leadingWidth: 64.0,
          leading: IconButton(
            icon: buildBackButton(null),
            onPressed: () => Get.back(),
          ).marginOnly(left: 8.0),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: GetBuilder<EditProfileController>(
          init: EditProfileController(),
          builder: (viewController) {
            return viewController.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildContainerTopHood(),
                        Expanded(
                          child: buildMainBody(viewController),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildMainBody(EditProfileController viewController) {
    return Container(
      decoration: boxDecorationSectionCardBackground,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  buildOldPasswordField(
                    hint: 'old_password'.tr,
                  ),
                  buildNewPasswordField(
                    hint: 'new_password'.tr,
                  ),
                  buildConfirmNewPasswordField(
                    hint: 'confirm_new_password'.tr,
                  ),
                ],
              ),
            ),
          ),
          buildFilledButton(
            onPressCallback: () {},
            title: "Save",
            padding: const EdgeInsets.only(
              top: 16.0,
            ),
          ),
        ],
      ),
    ).marginAll(16.0);
  }

  Widget buildOldPasswordField({
    String? hint,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        decoration: boxDecorationBorderForm,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GetBuilder<ChangePasswordController>(
          id: "text_form_field_old_password",
          init: ChangePasswordController(),
          builder: (viewController) {
            return TextFormField(
              obscureText: !viewController.isOldPasswordVisible,
              style: textStyleInputForm,
              keyboardType: TextInputType.visiblePassword,
              decoration: inputDecorationForm.copyWith(
                hintText: hint,
                suffixIcon: GestureDetector(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    viewController.isOldPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: colorTextSecondary,
                  ),
                  onTap: () {
                    viewController.toggleOldPasswordVisibility();
                  },
                ),
              ),
              controller: viewController.oldPasswordController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildNewPasswordField({
    String? hint,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        decoration: boxDecorationBorderForm,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GetBuilder<ChangePasswordController>(
          id: "text_form_field_new_password",
          init: ChangePasswordController(),
          builder: (viewController) {
            return TextFormField(
              obscureText: !viewController.isNewPasswordVisible,
              style: textStyleInputForm,
              keyboardType: TextInputType.visiblePassword,
              decoration: inputDecorationForm.copyWith(
                hintText: hint,
                suffixIcon: GestureDetector(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    viewController.isNewPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: colorTextSecondary,
                  ),
                  onTap: () {
                    viewController.toggleNewPasswordVisibility();
                  },
                ),
              ),
              controller: viewController.newPasswordController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildConfirmNewPasswordField({
    String? hint,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        decoration: boxDecorationBorderForm,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GetBuilder<ChangePasswordController>(
          id: "text_form_field_confirm_new_password",
          init: ChangePasswordController(),
          builder: (viewController) {
            return TextFormField(
              obscureText: !viewController.isConfirmNewPasswordVisible,
              style: textStyleInputForm,
              keyboardType: TextInputType.visiblePassword,
              decoration: inputDecorationForm.copyWith(
                hintText: hint,
                suffixIcon: GestureDetector(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    viewController.isConfirmNewPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: colorTextSecondary,
                  ),
                  onTap: () {
                    viewController.toggleConfirmNewPasswordVisibility();
                  },
                ),
              ),
              controller: viewController.confirmNewPasswordController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
              ],
            );
          },
        ),
      ),
    );
  }
}
