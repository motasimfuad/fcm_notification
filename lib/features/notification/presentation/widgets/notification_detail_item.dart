import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/k_card.dart';

class NotificationDetailItem extends StatelessWidget {
  final String? label;
  final String? value;
  final bool? hasBottomMargin;
  final Color? bgColor;
  final bool? showItem;
  const NotificationDetailItem({
    Key? key,
    this.label,
    this.value,
    this.hasBottomMargin = true,
    this.bgColor,
    this.showItem = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (value != null && value!.isNotEmpty)
        ? Column(
            children: [
              label != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 10.w, bottom: 6.w),
                      child: Row(
                        children: [
                          Text(
                            label ?? '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: KColors.primary.shade300,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: (hasBottomMargin == false) ? 0 : 20.w,
                ),
                child: KCard(
                  color: bgColor ?? KColors.primary,
                  radius: 15.r,
                  yPadding: 0.w,
                  xPadding: 0.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 13.w,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            value ?? 'Not Available',
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: KColors.primary.shade300,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
