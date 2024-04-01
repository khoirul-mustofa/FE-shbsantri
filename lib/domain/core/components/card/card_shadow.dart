import 'package:flutter/material.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';

import '../../../../infrastructure/theme/color/colors.dart';
import '../../../../infrastructure/theme/theme.dart';

class CardShadow extends StatelessWidget {
  const CardShadow({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: theme.style.padding.allLarge,
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: theme.style.borderRadius.allLarge,
            boxShadow: theme.style.shadow.medium),
        child: child);
  }
}
