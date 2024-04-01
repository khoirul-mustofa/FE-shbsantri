import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../infrastructure/theme/theme.dart';

class InfinitiPage {
  static Widget progress(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Center(
        child: CupertinoActivityIndicator(
          radius: 12.r,
        ),
      ),
    );
  }

  static Widget empty(BuildContext context, String type) {
    return Center(
      child: Text("Oops! $type belum tersedia", style: theme.font.f12),
    );
  }

  static Widget error(BuildContext context) {
    return Center(child: Text('Error', style: theme.font.f12));
  }
}
