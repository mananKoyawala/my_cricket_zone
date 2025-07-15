import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/constants.dart';

class AppLoader {
  // * show loader
  static showLoader() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 1)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50
      ..radius = 10.0
      ..indicatorColor = primaryColor
      ..userInteractions = false
      ..dismissOnTap = false
      ..textColor = transparent
      ..backgroundColor = white
      ..animationStyle = EasyLoadingAnimationStyle.offset
      ..maskType = EasyLoadingMaskType.black;
    return EasyLoading.show();
  }

  // * dismiss the loader
  static dismissLoader() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}
