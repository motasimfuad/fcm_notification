import 'package:fcm_notification/features/application/presentation/widgets/app_list_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';

class AppListItem extends StatelessWidget {
  const AppListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      margin: EdgeInsets.only(
        bottom: 18.h,
      ),
      decoration: BoxDecoration(
        color: KColors.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AppListImage(),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Notifications: 0',
                        style: TextStyle(
                          color: KColors.primaryLight,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Name akdshf aa dhfsoaiu',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: KColors.secondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Icon(
            Icons.more_vert_outlined,
            color: KColors.primaryLight,
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.more_vert_outlined,
          //     color: Colors.white,
          //   ),
          // )
        ],
      ),
    );
  }
}
