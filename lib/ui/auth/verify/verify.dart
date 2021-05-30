import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/auth/verify/verify_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerificationPage extends StatelessWidget {
  final String emailPhone;

  VerificationPage({required this.emailPhone});

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: colorInputFieldBackground,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: colorInputFieldBorder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GetBuilder<VerifyController>(
            id: "body",
            init: VerifyController(),
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
                              child: Image.asset(
                                'images/ic_lock_large.png',
                                fit: BoxFit.fitHeight,
                                height: 64,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              child: Text(
                                'verification_title'.tr,
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
                                bottom: 32.0,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: 'verification_subtitle'.tr,
                                  style: textStyleCaption1.copyWith(
                                    fontSize: 16.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      text: "$emailPhone",
                                      style: textStyleCaption2.copyWith(
                                        fontSize: 16.0,
                                      ),
                                    )
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                              ),
                              child: PinPut(
                                fieldsCount: 4,
                                controller: viewController.codeController,
                                submittedFieldDecoration: _pinPutDecoration,
                                followingFieldDecoration: _pinPutDecoration,
                                selectedFieldDecoration: _pinPutDecoration,
                                textStyle: textStyleSectionTitle,
                                onSubmit: (String pin) {},
                                fieldsAlignment: MainAxisAlignment.spaceEvenly,
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            buildFilledButton(
                              onPressCallback: () {
                                viewController.verify(emailPhone: emailPhone);
                              },
                              backgroundColor: colorPrimary,
                              title: 'sign_up'.tr,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'verification_bottom_line_part_1'.tr,
                                style: textStyleCaption1.copyWith(
                                  fontSize: 14.0,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // TODO: Call the "resend_code" API
                                      },
                                    text: 'verification_bottom_line_part_2'.tr,
                                    style: textStyleCaption2.copyWith(
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
