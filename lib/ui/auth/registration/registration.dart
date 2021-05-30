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
/*                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 8.0,
                            ),
                            child: CircleAvatar(
                              radius: 38,
                              backgroundColor: colorPrimary,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 35,
                                backgroundImage: AssetImage(
                                  'images/ic_user_avatar.png',
                                ),
                              ),
                            ),
                          ),*/
/*                          buildTextFormField(
                            controller: registrationController.nameController,
                            hint: 'name'.tr,
                            inputType: TextInputType.text,
                          ),*/
                          buildTextFormField(
                            controller: viewController.emailPhoneController,
                            hint: 'email_phone'.tr,
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
                              bottom: 16.0,
                              top: 32.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: colorTextSecondary,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    'registration_or_continue_with'.tr,
                                    style: textStyleCaption1.copyWith(
                                      fontSize: 14.0,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: colorTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildSocialLoginItem(
                                  imagePath: 'images/ic_google.png',
                                ),
                                buildSocialLoginItem(
                                  imagePath: 'images/ic_facebook.png',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                              bottom: 32.0,
                              top: 16.0,
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
                        ? Icons.visibility
                        : Icons.visibility_off,
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
                        ? Icons.visibility
                        : Icons.visibility_off,
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
