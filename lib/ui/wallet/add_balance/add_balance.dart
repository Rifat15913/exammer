import 'package:exammer/common.dart';
import 'package:exammer/constants.dart';
import 'package:exammer/ui/wallet/add_balance/add_balance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddBalancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyleGlobal,
      child: Scaffold(
        backgroundColor: colorPageBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Add Balance",
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
        body: GetBuilder<AddBalanceController>(
          init: AddBalanceController(),
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

  Widget buildMainBody(AddBalanceController viewController) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: boxDecorationSectionCardBackground,
            margin: const EdgeInsets.only(bottom: 16.0),
            padding: const EdgeInsets.all(16.0),
            child: buildTopSection(),
          ),
          Expanded(
            child: Container(
              decoration: boxDecorationSectionCardBackground,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildTextFormField(
                            controller: viewController.cardNumberController,
                            hint: "Card Number",
                            inputType: TextInputType.numberWithOptions(),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: buildTextFormField(
                                  controller:
                                      viewController.expiredTimeController,
                                  hint: "MM/YY",
                                  inputType: TextInputType.numberWithOptions(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: buildTextFormField(
                                  controller: viewController.cvvController,
                                  hint: "CVV",
                                  inputType: TextInputType.numberWithOptions(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                ),
                                flex: 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  buildFilledButton(
                    onPressCallback: () {},
                    title: "Add Money",
                    padding: const EdgeInsets.only(
                      top: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Select Method",
          style: textStyleSectionTitle,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.only(top: 16.0),
          child: GetBuilder<AddBalanceController>(
            id: "list_view_payment_method_section",
            init: AddBalanceController(),
            builder: (viewController) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      viewController.selectItemFromPaymentMethods(index);
                    },
                    child: Container(
                      width: 104,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: colorItemInactiveBackground,
                        border: Border.all(
                          color: getBorderColor(
                            viewController,
                            index,
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Center(
                        child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 12.0,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Color getBorderColor(AddBalanceController viewController, int index) {
    return (viewController.selectedIndexMap.containsKey('top') &&
            viewController.selectedIndexMap['top'] == index)
        ? colorItemActiveBackground
        : colorItemInactiveBackground;
  }
}
