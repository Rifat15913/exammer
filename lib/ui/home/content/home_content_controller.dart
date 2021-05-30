import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContentController extends GetxController {
  late bool isLoading;
  var _tapPosition;

  @override
  void onInit() {
    isLoading = false;

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  RelativeRect buildRectForPointsMenu(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;

    return RelativeRect.fromRect(
        _tapPosition & const Size(0, 0), // smaller rect, the touch area
        Offset.zero & overlay.size // Bigger rect, the entire screen
        );
  }
}
