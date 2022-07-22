import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/k_card.dart';

AnimateIconController animateIconController = AnimateIconController();

class AppDetailsToggleIcon extends StatelessWidget {
  final double? iconSize;
  final Function()? onTap;
  final IconData? icon;
  final bool Function() onStartIconPress;
  final bool Function() onEndIconPress;
  const AppDetailsToggleIcon({
    Key? key,
    this.iconSize,
    this.onTap,
    this.icon,
    required this.onStartIconPress,
    required this.onEndIconPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KCard(
      color: KColors.primary,
      xPadding: 0.w,
      yPadding: 0.w,
      radius: 200,
      hasShadow: false,
      onTap: onTap,
      child: SizedBox(
        height: 30.w,
        width: 30.w,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: AnimateIcons(
            startIcon: Icons.keyboard_arrow_down_rounded,
            endIcon: Icons.keyboard_arrow_up_rounded,
            controller: animateIconController,
            size: 35.w,
            onStartIconPress: onStartIconPress,
            onEndIconPress: onEndIconPress,
            duration: const Duration(milliseconds: 400),
            startIconColor: KColors.secondary,
            endIconColor: KColors.secondary,
            clockwise: false,
          ),
        ),
      ),
    );
  }
}
