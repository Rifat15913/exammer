import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  late bool isLoading;
  late ScrollController scrollController;
  late String selectedTime;

  late StreamSubscription<Event> _resultSubscription;
  late DatabaseReference resultRef;

  @override
  void onInit() {
    isLoading = false;
    scrollController = ScrollController();

    resultRef = FirebaseDatabase.instance.reference().child("result");
    resultRef.keepSynced(true);

    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _resultSubscription.cancel();

    super.dispose();
  }

  void changeSubject(String newSubject) {
    selectedTime = newSubject;
  }
}
