// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ScreenSizeCategory {
  Small,
  Medium,
  Large,
  ExtraLarge,
}

double getResponsiveLength(double baseLength, Axis axis) {
  final context = MediaQueryData.fromView(WidgetsBinding.instance.window).size;
  final screenSize = axis == Axis.vertical ? context.height : context.width;
  final scaleFactor = getScaleFactor(screenSize);
  return baseLength * scaleFactor;
}

double getScaleFactor(double screenSize) {
  if (screenSize < 480) {
    return 0.8;
  } else if (screenSize >= 480 && screenSize < 720) {
    return 1.0;
  } else if (screenSize >= 720 && screenSize < 1024) {
    return 1.2;
  } else {
    return 1.5;
  }
}

double getHeightScale(double scale) {
  final context = MediaQueryData.fromView(WidgetsBinding.instance.window).size;
  final screenSize = context.height;
  return screenSize / scale;
}

double getWidthScale(double scale) {
  final context = MediaQueryData.fromView(WidgetsBinding.instance.window).size;
  final screenSize = context.width;
  return screenSize / scale;
}

double get getHeightAppBar {
  final paddingTop =
      MediaQueryData.fromView(WidgetsBinding.instance.window).padding.top;
  return kToolbarHeight + paddingTop;
}

ScreenSizeCategory detectScreenSizeCategory(BuildContext context) {
  final double screenHeight = MediaQuery.of(context).size.height;

  if (screenHeight < 480) {
    return ScreenSizeCategory.Small;
  } else if (screenHeight >= 480 && screenHeight < 720) {
    return ScreenSizeCategory.Medium;
  } else if (screenHeight >= 720 && screenHeight < 1024) {
    return ScreenSizeCategory.Large;
  } else {
    return ScreenSizeCategory.ExtraLarge;
  }
}

double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  ScreenSizeCategory screenSizeCategory = detectScreenSizeCategory(context);
  double scaleFactor = 1.0;
  switch (screenSizeCategory) {
    case ScreenSizeCategory.Small:
      scaleFactor = 0.6;
      break;
    case ScreenSizeCategory.Medium:
      scaleFactor = 0.8;
      break;
    case ScreenSizeCategory.Large:
      scaleFactor = 1.0;
      break;
    case ScreenSizeCategory.ExtraLarge:
      scaleFactor = 1.2;
      break;
  }
  return baseFontSize * scaleFactor;
}

extension AdaptiveSizeExtension on num {
  double get hr {
    return (this / 1080) * ScreenUtil().screenHeight;
  }

  double get wr {
    return (this / 1920) * ScreenUtil().screenWidth;
  }
}
