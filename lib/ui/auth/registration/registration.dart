import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/auth/registration/registration_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<RegistrationController>(
          id: "body",
          init: RegistrationController(),
          builder: (viewController) {
            return viewController.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: buildBackButton(
                                  () => Get.back(),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'registration_title'.tr,
                              style: textStylePageTitle,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                              bottom: 24.0,
                            ),
                            child: Text(
                              'registration_subtitle'.tr,
                              style: textStylePageSubtitle,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          buildTextFormField(
                            controller: viewController.emailAddressController,
                            hint: 'email_address'.tr,
                            inputType: TextInputType.emailAddress,
                          ),
                          buildPasswordField(
                            controller: viewController.passwordController,
                            hint: 'password'.tr,
                            inputType: TextInputType.visiblePassword,
                          ),
                          buildConfirmPasswordField(
                            controller:
                                viewController.confirmPasswordController,
                            hint: 'confirm_password'.tr,
                            inputType: TextInputType.visiblePassword,
                          ),
                          buildUserTypeSelectionSegment(),
                          SizedBox(
                            height: 16.0,
                          ),
                          buildFilledButton(
                            onPressCallback: () {
                              viewController.register();
                            },
                            backgroundColor: colorPrimary,
                            title: 'registration_get_started'.tr,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'registration_already_have_account'.tr,
                              style: textStyleCaption1.copyWith(
                                fontSize: 14.0,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.back();
                                    },
                                  text: 'sign_in'.tr,
                                  style: textStyleCaption2.copyWith(
                                    fontSize: 14.0,
                                  ),
                                )
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                              bottom: 32.0,
                              top: 48.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'registration_you_agree_to_our_policy'.tr,
                                style: textStyleCaption1,
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                    text: 'terms_and_conditions'.tr,
                                    style: textStyleCaption2,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  GetBuilder<RegistrationController> buildUserTypeSelectionSegment() {
    return GetBuilder<RegistrationController>(
      id: "user_type",
      init: RegistrationController(),
      builder: (RegistrationController viewController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildUserTypeItem(
                () {
                  if (viewController.selectedType != userTypeStudent) {
                    viewController.toggleType(userTypeStudent);
                  }
                },
                viewController.selectedType == userTypeStudent,
                'student'.tr,
              ),
              SizedBox(width: 16.0),
              buildUserTypeItem(
                () {
                  if (viewController.selectedType != userTypeTeacher) {
                    viewController.toggleType(userTypeTeacher);
                  }
                },
                viewController.selectedType == userTypeTeacher,
                'teacher'.tr,
              ),
            ],
          ),
        );
      },
    );
  }

  Expanded buildUserTypeItem(
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
                fontSize: 14.0,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: selectingCondition
                ? colorAccent
                : colorTextSecondary.withOpacity(0.15),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required TextInputType inputType,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 8.0,
      ),
      child: Container(
        decoration: boxDecorationBorderForm,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GetBuilder<RegistrationController>(
          id: "text_form_field_password",
          init: RegistrationController(),
          builder: (registrationController) {
            return TextFormField(
              obscureText: (inputType == TextInputType.visiblePassword) &&
                  !registrationController.isPasswordVisible,
              style: textStyleInputForm,
              keyboardType: inputType,
              decoration: inputDecorationForm.copyWith(
                hintText: hint,
                suffixIcon: GestureDetector(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    registrationController.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: colorTextRegular,
                  ),
                  onTap: () {
                    registrationController.togglePasswordVisibility();
                  },
                ),
              ),
              controller: controller,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildConfirmPasswordField({
    required TextEditingController controller,
    required String hint,
    required TextInputType inputType,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 8.0,
      ),
      child: Container(
        decoration: boxDecorationBorderForm,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GetBuilder<RegistrationController>(
          id: "text_form_field_confirm_password",
          init: RegistrationController(),
          builder: (registrationController) {
            return TextFormField(
              obscureText: (inputType == TextInputType.visiblePassword) &&
                  !registrationController.isConfirmPasswordVisible,
              style: textStyleInputForm,
              keyboardType: inputType,
              decoration: inputDecorationForm.copyWith(
                hintText: hint,
                suffixIcon: GestureDetector(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    registrationController.isConfirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: colorTextRegular,
                  ),
                  onTap: () {
                    registrationController.toggleConfirmPasswordVisibility();
                  },
                ),
              ),
              controller: controller,
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
