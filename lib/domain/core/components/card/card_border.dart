import 'package:flutter/material.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';

import '../../../../infrastructure/theme/theme.dart';

class CardBorder extends StatelessWidget {
  const CardBorder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: theme.style.padding.allLarge,
      decoration: BoxDecoration(
        borderRadius: theme.style.borderRadius.allLarge,
        border: theme.style.boder,
      ),
      child: child,
    );
  }
}
