import 'package:get/get.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';

import 'style/style.dart';

class AppTheme {
  AppFonts get font => AppFonts();
  AppStyle get style => AppStyle(Get.context!);
}

AppTheme get theme => AppTheme();
