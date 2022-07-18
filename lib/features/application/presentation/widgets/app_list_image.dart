import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/constants/colors.dart';

class AppListImage extends StatelessWidget {
  final Uint8List? image;
  const AppListImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.w,
      width: 65.w,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: KColors.primary.shade700,
        // color: Colors.white,
        borderRadius: BorderRadius.circular(17.r),
        border: Border.all(
          color: KColors.primary.shade700,
          // color: Colors.white,
          width: 2.w,
        ),
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(15.r),
        child: Image.memory(
          image ?? Uint8List.fromList([]),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.image,
                color: KColors.primary.shade300,
                size: 20.w,
              ),
              // child: Text(
              //   'Image not loaded!',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 10.sp,
              //   ),
              // ),
            );
          },
        ),
      ),
    );
  }
}
