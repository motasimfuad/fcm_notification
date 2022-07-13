import 'package:fcm_notification/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppListImage extends StatelessWidget {
  const AppListImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.w,
      width: 65.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: KColors.primary.shade50,
        // color: Colors.white,
        borderRadius: BorderRadius.circular(17.r),
        border: Border.all(
          color: Colors.white,
          width: 2.w,
        ),
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(15.r),
        child: Image.network(
          'https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F82127fd0-aeaf-4495-8487-b68dbae409e9%2Flogo.png?table=block&id=8c8df4f8-b844-4b34-ae40-9f534f698876&spaceId=3107c0c8-1d6e-462e-8ab2-26ba76caa796&width=600&userId=73918c78-f0a6-467b-83c8-c747d80076b1&cache=v2',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
