import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/auth/reset_password/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ResetPasswordController>(
          id: "body",
          init: ResetPasswordController(),
          builder: (viewController) {
            return viewController.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              top: 72.0,
                              bottom: 8.0,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'reset_password_title'.tr,
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
                              'reset_password_subtitle'.tr,
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
                          SizedBox(
                            height: 16.0,
                          ),
                          buildFilledButton(
                            onPressCallback: () {
                              viewController.resetPassword();
                            },
                            backgroundColor: colorPrimary,
                            title: 'reset_password'.tr,
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
}
