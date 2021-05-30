import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/profile/change_password/change_password.dart';
import 'package:exammer/ui/profile/edit/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Edit Profile",
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
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(
                        color: colorAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: colorTextRegular.withOpacity(0.8),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'images/ic_camera.png',
                            fit: BoxFit.cover,
                            height: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ).marginSymmetric(vertical: 16.0),
                  buildTextFormField(
                    controller: viewController.nameController,
                    hint: 'name'.tr,
                    inputType: TextInputType.text,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                  ),
                  buildTextFormField(
                    controller: viewController.emailController,
                    hint: 'email_address'.tr,
                    inputType: TextInputType.emailAddress,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                  ),
                  buildTextFormField(
                    controller: viewController.phoneController,
                    hint: 'phone_number'.tr,
                    inputType: TextInputType.phone,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ChangePasswordPage());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: colorAccent,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'images/ic_key.png',
                            fit: BoxFit.cover,
                            height: 24.0,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Change Password",
                            style: textStylePageSubtitle.copyWith(
                              color: colorTextRegular,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ).marginSymmetric(horizontal: 16.0),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: colorTextSecondary,
                          size: 20.0,
                        )
                      ],
                    ).marginOnly(top: 16.0),
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
}
