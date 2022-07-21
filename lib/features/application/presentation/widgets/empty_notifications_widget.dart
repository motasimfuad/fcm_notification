import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';

class EmptyNotificationsWidget extends StatelessWidget {
  const EmptyNotificationsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'No notifications found!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: KColors.primaryLight,
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
        ListView(
          physics: const AlwaysScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
