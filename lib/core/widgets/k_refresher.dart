import 'package:flutter/material.dart';

import '../constants/colors.dart';

class KRefresher extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  const KRefresher({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: KColors.primary,
      backgroundColor: KColors.secondary,
      child: child,
    );
  }
}
