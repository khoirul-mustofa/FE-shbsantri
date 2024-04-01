import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:santrihub/infrastructure/theme/font/fonts.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';

import '../../../../infrastructure/theme/color/colors.dart';
import '../../../../infrastructure/theme/theme.dart';

class AppBarDashboard extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      flexibleSpace: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: theme.style.padding.leftSmall,
                child: Text('SanHub', style: theme.font.f22.primary.semibold),
              )),
          Container(
            height: 22.h,
            width: 1,
            color: kSoftGrey,
          ),
          Expanded(flex: 13, child: Container())
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
