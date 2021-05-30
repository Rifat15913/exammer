import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/competition/demand/enter_the_code/enter_the_code_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EnterTheCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Enter Code",
            style: textStyleAppBar,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          brightness: Brightness.light,
          leadingWidth: 64.0,
          leading: IconButton(
            icon: buildBackButton(null),
            onPressed: () => Get.back(result: true),
          ).marginOnly(left: 8.0),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: GetBuilder<EnterTheCodeController>(
          init: EnterTheCodeController(),
          builder: (controller) {
            return controller.isLoading
                ? centralProgressIndicator
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildContainerTopHood(),
                        Expanded(
                          child: buildBody(),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildBody() {
    return GetBuilder<EnterTheCodeController>(
      init: EnterTheCodeController(),
      builder: (viewController) {
        return Container(
          decoration: boxDecorationSectionCardBackground.copyWith(
            color: Colors.transparent,
          ),
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: boxDecorationSectionCardBackground,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Enter the code",
                      style: textStyleHoodTitle,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).paddingSymmetric(horizontal: 24.0),
                    Text(
                      "Enter your competition code below to start the competition",
                      style: textStylePopupMenuTitle,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ).marginOnly(
                      bottom: 24.0,
                      left: 24.0,
                      right: 24.0,
                      top: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: boxDecorationBorderForm,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              style: textStyleInputForm,
                              keyboardType: TextInputType.number,
                              decoration: inputDecorationForm.copyWith(
                                hintText: "Code",
                              ),
                              controller: viewController.codeController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(null),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16.0,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(6.0),
                              ),
                            ),
                            backgroundColor: colorAccent,
                          ),
                          onPressed: () {},
                          child: Text(
                            "Register Now",
                            style: textStyleFilledButton.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/ic_calendar.png",
                      fit: BoxFit.fitWidth,
                      width: 24.0,
                    ).marginOnly(right: 4.0),
                    Text(
                      "12 Dec, 2020",
                      style: textStyleHoodSubtitle,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/ic_clock.png",
                      fit: BoxFit.fitWidth,
                      width: 24.0,
                    ).marginOnly(right: 4.0),
                    Text(
                      "2:30 PM - 4:00 PM",
                      style: textStyleHoodSubtitle,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ).marginOnly(bottom: 8.0),
            Text(
              "Mathematics Beginner Course",
              style: textStyleSectionTitle.copyWith(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Get 1000 credits for each friend after they make their first purchase",
              style: textStylePageSubtitle.copyWith(
                fontSize: 14.0,
              ),
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ).marginOnly(
              bottom: 12.0,
              top: 4.0,
            ),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(6.0),
                      ),
                    ),
                    backgroundColor: colorAccent,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Enter Code",
                    style: textStyleFilledButton.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(6.0),
                      ),
                      side: const BorderSide(
                        color: colorAccent,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Leaderboard",
                    style: textStyleFilledButton.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: colorAccent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
