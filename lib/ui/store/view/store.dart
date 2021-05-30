import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/store/view/store_controller.dart';
import 'package:exammer/util/helper/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Exammer Store",
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
          actions: [
            buildInfoAction(),
          ],
        ),
        body: GetBuilder<StoreController>(
          init: StoreController(),
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

  Widget buildInfoAction() {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Image.asset(
          "images/ic_info.png",
          fit: BoxFit.fitHeight,
          height: 24.0,
        ),
      ).paddingOnly(right: 16.0),
    );
  }

  Widget buildBody() {
    return GetBuilder<StoreController>(
      id: "list_view_store_items",
      init: StoreController(),
      builder: (viewController) {
        return Container(
          margin: const EdgeInsets.all(16.0),
          child: ListView.separated(
            controller: viewController.scrollController,
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: 50,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return buildStoreItem();
            },
          ),
        );
      },
    );
  }

  Widget buildStoreItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: boxDecorationSectionCardBackground,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Lifelines:",
              style: textStyleSectionTitle,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            buildStoreSubItem(
              marginTop: 24.0,
              iconPath: "images/ic_fleep.png",
              title: "Fleep",
              subtitle: "Eliminate 2 incharel points",
              price: "\$100",
              buttonText: "Buy",
              onTap: () {},
            ),
            buildStoreSubItem(
              marginTop: 16.0,
              iconPath: "images/ic_fleep.png",
              title: "Fleep",
              subtitle: "Eliminate 2 incharel points",
              price: "\$100",
              buttonText: "Buy",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Container buildStoreSubItem({
    required double marginTop,
    String? iconPath,
    required String title,
    required String price,
    required String subtitle,
    required String buttonText,
    required GestureTapCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(
          const Radius.circular(16.0),
        ),
        border: const Border.fromBorderSide(
          const BorderSide(color: colorInputFieldBorder),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextUtil.isNotEmpty(iconPath)
                  ? Image.asset(
                      iconPath!,
                      fit: BoxFit.fitWidth,
                      width: 20.0,
                    ).marginOnly(right: 8.0)
                  : SizedBox.shrink(),
              Expanded(
                child: Text(
                  title,
                  style: textStyleHoodTitle.copyWith(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Text(
                price,
                style: textStyleSectionSubtitle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ).marginOnly(left: 8.0),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  style: textStylePopupMenuTitle,
                ),
              ),
              Row(
                children: [
                  Text(
                    "-",
                    style: textStylePopupMenuTitle.copyWith(
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    "01",
                    style: textStyleRegularBody.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).marginSymmetric(horizontal: 12.0),
                  Text(
                    "+",
                    style: textStylePopupMenuTitle.copyWith(
                      fontSize: 26.0,
                    ),
                  ),
                ],
              ).marginOnly(left: 16.0),
            ],
          ).marginOnly(top: 8.0, bottom: 4.0),
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
            onPressed: onTap,
            child: Text(
              buttonText,
              style: textStyleFilledButton.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
