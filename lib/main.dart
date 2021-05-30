import 'dart:async';

import 'package:exammer/constants.dart';
import 'package:exammer/essential/app_configuration.dart';
import 'package:exammer/essential/translations.dart';
import 'package:exammer/ui/auth/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZonedGuarded<Future<void>>(
    () async {
      AppConfiguration appConfig = AppConfiguration();
      await GetStorage.init();

      runApp(
        MyApp(appConfig: appConfig),
      );
    },
    FirebaseCrashlytics.instance.recordError,
  );
}

class MyApp extends StatelessWidget {
  final AppConfiguration appConfig;

  MyApp({required this.appConfig});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return ChangeNotifierProvider<AppConfiguration>(
      create: (BuildContext context) => appConfig,
      child: Consumer<AppConfiguration>(
        builder: (context, model, child) {
          return GetMaterialApp(
            translations: Messages(),
            locale: Locale('en'),
            fallbackLocale: Locale('en'),
            theme: ThemeData(
              backgroundColor: Colors.white,
              primaryColor: colorPrimary,
              accentColor: colorAccent,
              fontFamily: 'Poppins',
            ),
            debugShowCheckedModeBanner: true,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
