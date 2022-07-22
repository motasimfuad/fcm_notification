import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class NotificationTypeInfoWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const NotificationTypeInfoWidget({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: KColors.secondary,
          size: 12.w,
        ),
        SizedBox(width: 4.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: KColors.primaryLight,
          ),
        ),
      ],
    );
  }
}
