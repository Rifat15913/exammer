import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/others/faqs/faqs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FaqsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "FAQs",
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
        body: GetBuilder<FaqsController>(
          init: FaqsController(),
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
                          child: buildFaqSegment(context),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildFaqSegment(BuildContext context) {
    return GetBuilder<FaqsController>(
      id: "list_view_faqs",
      init: FaqsController(),
      builder: (viewController) {
        return Container(
          decoration: boxDecorationSectionCardBackground,
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            controller: viewController.scrollController,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Divider(
                height: 1.0,
                color: colorTextSecondary,
              ),
            ),
            itemCount: 50,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return buildFaqItem(context);
            },
          ),
        ).marginAll(16.0);
      },
    );
  }

  Widget buildFaqItem(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: false,
        title: RichText(
          text: TextSpan(
            text: 'Q. ',
            style: textStylePopupMenuSubtitle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
            children: [
              TextSpan(
                text:
                    'Does the Exammer offer or have any type of training programs available?',
                style: textStylePopupMenuSubtitle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
              )
            ],
          ),
          textAlign: TextAlign.start,
        ),
        children: [
          RichText(
            text: TextSpan(
              text: 'A. ',
              style: textStylePopupMenuSubtitle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
              ),
              children: [
                TextSpan(
                  text:
                      'Yes - our sustaining member companies regularly post openings to the AES Job Board: www.aes.org/jobs. Other companies also sometimes publish jobs in the AES Journal: www.aes.org/journal/wantads.',
                  style: textStylePopupMenuSubtitle.copyWith(
                    fontWeight: FontWeight.w400,
                    color: colorTextSecondary,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
            textAlign: TextAlign.start,
          ).marginOnly(left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
        ],
      ),
    );
  }
}
