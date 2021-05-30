import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/auth/login/login_controller.dart';
import 'package:exammer/ui/auth/registration/registration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<LoginController>(
          id: "body",
          init: LoginController(),
          builder: (viewController) {
            return viewController.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 72.0,
                              bottom: 8.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'login_title_part_1'.tr,
                                style: textStylePageTitle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                              bottom: 32.0,
                            ),
                            child: Text(
                              'login_subtitle'.tr,
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
/*                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 32.0,
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'forgot_password'.tr,
                                  textAlign: TextAlign.end,
                                  style: textStyleWarning,
                                ),
                              ),
                            ),
                          ),*/
                          SizedBox(
                            height: 16.0,
                          ),
                          buildFilledButton(
                            onPressCallback: () {
                              viewController.login();
                            },
                            backgroundColor: colorPrimary,
                            title: 'sign_in'.tr,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'login_do_not_have_account'.tr,
                              style: textStyleCaption1.copyWith(
                                fontSize: 14.0,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => RegistrationPage());
                                    },
                                  text: 'login_register'.tr,
                                  style: textStyleCaption2.copyWith(
                                    fontSize: 14.0,
                                  ),
                                )
                              ],
                            ),
                          ),
/*                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                              bottom: 16.0,
                              top: 48.0,
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
                                    style: TextStyle(
                                      color: colorTextSecondary,
                                      fontSize: 14.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
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
                          ),*/
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                              bottom: 32.0,
                              top: 48.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'login_you_agree_to_our_policy'.tr,
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
        child: GetBuilder<LoginController>(
          id: "text_form_field_password",
          init: LoginController(),
          builder: (loginController) {
            return TextFormField(
              obscureText: (inputType == TextInputType.visiblePassword) &&
                  !loginController.isPasswordVisible,
              style: textStyleInputForm,
              keyboardType: inputType,
              decoration: inputDecorationForm.copyWith(
                hintText: hint,
                suffixIcon: GestureDetector(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    loginController.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: colorTextRegular,
                  ),
                  onTap: () {
                    loginController.togglePasswordVisibility();
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
