import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';

class AppListItem extends StatelessWidget {
  const AppListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 12.h,
      ),
      margin: EdgeInsets.only(
        bottom: 15.h,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppListImage(),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name akdshf aa dhfsoaiu sdasjf  adsfads f',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: KColors.secondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'Notifications: 0',
                        style: TextStyle(
                          color: KColors.primaryLight,
                          fontSize: 13.sp,
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

class AppListImage extends StatelessWidget {
  const AppListImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.w,
      width: 45.w,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15.r),
      ),
    );
  }
}
