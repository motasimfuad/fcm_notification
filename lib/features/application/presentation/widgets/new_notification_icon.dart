import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/k_card.dart';

class NewNotificationIcon extends StatelessWidget {
  final double? iconSize;
  final Function()? onTap;
  const NewNotificationIcon({
    Key? key,
    this.iconSize,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KCard(
      color: KColors.primary,
      xPadding: 8.w,
      yPadding: 8.w,
      radius: 200,
      hasBorder: true,
      hasShadow: false,
      borderColor: KColors.secondary,
      onTap: onTap,
      child: Icon(
        Icons.notification_add_rounded,
        color: KColors.secondary,
        size: iconSize ?? 22.w,
      ),
    );
  }
}
