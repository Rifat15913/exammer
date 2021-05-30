import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

// Default values
const bool defaultBoolean = false;
const int defaultInt = 0;
const double defaultDouble = 0.0;
const String defaultString = "";
const String spaceString = " ";
const String newLineString = "\n";

// App colors (main)
const Color colorPrimary = const Color(0xFF3580F7);
const Color colorAccent = const Color(0xFF3580F7);

// App colors (text)
const Color colorTextRegular = const Color(0xFF1E263C);
const Color colorTextSecondary = const Color(0xFFB9BAC8);
const Color colorTextTertiary = const Color(0xFF6B7285);
const Color colorTextWarning = const Color(0xFFF1775C);

// App colors (others)
const Color colorInputFieldBackground = const Color(0xFFF9F9F9);
const Color colorInputFieldBorder = const Color(0xFFEEEEEE);
const Color colorPageBackground = const Color(0xFFF4F5F7);
const Color colorItemInactiveBackground = const Color(0xFFEBF2FE);
const Color colorItemActiveBackground = const Color(0xFF3580F7);
const Color colorExamItemInactiveBackground = const Color(0xFFF5F6FC);
const Color colorExamItemActiveBackground = const Color(0xFF3580F7);
const Color colorUserActive = const Color(0xFF00D563);
const Color colorWinningTeamBackground = const Color(0xFF6CE6E1);
const Color colorWinProgress = const Color(0xFF27AE60);
const Color colorLoseProgress = const Color(0xFFEB5757);
const Color colorTieProgress = colorAccent;
const Color colorSkipProgress = colorWinningTeamBackground;
const Color colorOrange = const Color(0xFFF2994A);

// Text styles
const TextStyle textStylePageTitle = const TextStyle(
  color: colorTextRegular,
  fontSize: 30.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w700,
);

const TextStyle textStylePageSubtitle = const TextStyle(
  color: colorTextSecondary,
  fontSize: 16.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
);

const TextStyle textStyleInputForm = const TextStyle(
  color: colorTextRegular,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);

const TextStyle textStyleInputFormHint = const TextStyle(
  color: colorTextSecondary,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);

const TextStyle textStyleCaption1 = const TextStyle(
  color: colorTextSecondary,
  fontSize: 12.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
);

const TextStyle textStyleCaption2 = const TextStyle(
  color: colorPrimary,
  fontSize: 12.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
);

const TextStyle textStyleWarning = const TextStyle(
  color: colorTextWarning,
  fontSize: 14.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
);

const TextStyle textStyleSectionTitle = const TextStyle(
  color: colorTextRegular,
  fontSize: 16.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
);

const TextStyle textStyleSectionSubtitle = const TextStyle(
  color: colorAccent,
  fontSize: 14.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
);

const TextStyle textStyleSectionItemTitle = const TextStyle(
  color: colorTextRegular,
  fontSize: 14.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
);

const TextStyle textStyleRegularBody = const TextStyle(
  color: colorTextRegular,
  fontSize: 14.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
);

const TextStyle textStyleSmallestBody = const TextStyle(
  color: colorTextSecondary,
  fontSize: 10.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
);

const TextStyle textStyleAppBar = const TextStyle(
  color: colorTextRegular,
  fontSize: 16.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w600,
);

const TextStyle textStyleHoodTitle = const TextStyle(
  color: colorTextRegular,
  fontSize: 20.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w600,
);

const TextStyle textStyleHoodSubtitle = const TextStyle(
  color: colorTextSecondary,
  fontSize: 14.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
);

const TextStyle textStylePopupMenuTitle = const TextStyle(
  color: colorTextTertiary,
  fontSize: 14.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
);

const TextStyle textStylePopupMenuSubtitle = const TextStyle(
  color: colorTextRegular,
  fontSize: 14.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
);

const TextStyle textStyleFilledButton = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 16.0,
);

const TextStyle textStyleListHeader = const TextStyle(
  color: colorTextTertiary,
  fontSize: 12.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
);

const TextStyle textStyleStatisticsBody = const TextStyle(
  color: Colors.white,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w600,
  fontSize: 18.0,
);

const TextStyle textStyleStatisticsCaption = const TextStyle(
  color: colorTextSecondary,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
  fontSize: 14.0,
);

// Input Decoration
const InputDecoration inputDecorationForm = const InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
  hintStyle: textStyleInputFormHint,
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  border: InputBorder.none,
);

// Box Decoration
const BoxDecoration boxDecorationBorderForm = const BoxDecoration(
  color: colorInputFieldBackground,
  borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
  border: const Border.fromBorderSide(
    const BorderSide(color: colorInputFieldBorder),
  ),
);

const BoxDecoration boxDecorationSectionCardBackground = const BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.all(
    const Radius.circular(20.0),
  ),
);

const BoxDecoration boxDecorationBackButtonBorder = const BoxDecoration(
  borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
  ),
  border: const Border.fromBorderSide(
    const BorderSide(color: colorTextSecondary),
  ),
);

// Shape
const RoundedRectangleBorder shapeButtonRectangle =
    const RoundedRectangleBorder(
  borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
  ),
);

const RoundedRectangleBorder shapeCardItemRectangle =
    const RoundedRectangleBorder(
  borderRadius: const BorderRadius.all(
    const Radius.circular(16.0),
  ),
);

// Widget
const Widget centralProgressIndicator = const Center(
  child: const CircularProgressIndicator(),
);

// Service
const SystemUiOverlayStyle systemUiOverlayStyleGlobal =
    const SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
);

// App essentials
const String responseOfJsonType = "application/json";
const int minimumPasswordLength = 8;
const int minimumVerificationCodeLength = 4;
const String prefixAuthToken = "Bearer ";
const String authErrorTypeWeakPassword = "weak-password";
const String authErrorTypeDuplicateEmail = "email-already-in-use";
const int userTypeStudent = 1;
const int userTypeTeacher = 2;

// Backend
const String baseDevelopmentUrl = "http://staging.exammer.top";
const String baseLiveUrl = "";
const String baseUrl = baseDevelopmentUrl;

const String baseAppDevelopmentUrl = "http://staging.exammer.top";
const String baseAppLiveUrl = "";
const String baseAppUrl = baseAppDevelopmentUrl;

final String baseApiUrl = join(baseAppUrl, "api");
final String loginUrl = join(baseApiUrl, "login");
final String surveyUrl = join(baseApiUrl, "survey");
final String registerUrl = join(baseApiUrl, "request-verification");
final String verifyRegistrationUrl = join(baseApiUrl, "verify");
final String dashboardUrl = join(baseApiUrl, "dashboard");

// Key
const String keySuccess = "success";
const String keyData = "data";
const String keyMessage = "message";
const String keyEmail = "email";
const String keyPassword = "password";
const String keyToken = "token";
const String keyAuthToken = "auth_token";
const String keyTrainingCategories = "training_categories";
const String keyTimeLengths = "time_lengths";
const String keyProfessions = "professions";
const String keyCategoryIconUrl = "cat_icon_url";
const String keySubmittedPreferences = "submitted_preferences";
const String keyTrainingCategory = "training_category";
const String keyTimeLength = "time_length";
const String keyProfession = "profession";
const String keyVerificationCode = "verification_code";
const String keyUserType = "user_type";
const String keyUserPreferences = "user_preferences";

// Regular Expression
const String regularExpressionEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const String regularExpressionPhone =
    "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
        "([0-9][0-9\\- \\.]+[0-9])";
