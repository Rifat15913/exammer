import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/profile/view/view_profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ViewProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        body: GetBuilder<ViewProfileController>(
          init: ViewProfileController(),
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
                          child: buildMainBody(),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildMainBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: boxDecorationSectionCardBackground,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorPageBackground,
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: colorAccent,
                      width: 2.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Image.network(
                      "${FirebaseAuth.instance.currentUser!.photoURL}",
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ).marginSymmetric(vertical: 16.0),
                Text(
                  "${FirebaseAuth.instance.currentUser!.displayName}",
                  style: textStyleHoodTitle.copyWith(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "Beginner",
                  style: textStyleHoodSubtitle,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ).marginOnly(top: 4.0, bottom: 16.0),
                Text(
                  "${FirebaseAuth.instance.currentUser!.email}",
                  style: textStyleCaption2.copyWith(
                    color: colorTextRegular,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ).marginOnly(bottom: 16.0),
              ],
            ),
          ).marginAll(16.0),
        ],
      ),
    );
  }
}
