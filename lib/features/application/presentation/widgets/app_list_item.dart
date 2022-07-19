import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fcm_notification/core/widgets/k_badge.dart';
import 'package:fcm_notification/core/widgets/k_card.dart';
import 'package:fcm_notification/core/widgets/k_menu.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/presentation/widgets/app_list_image.dart';

import '../../../../core/constants/colors.dart';

class AppListItem extends StatelessWidget {
  final AppEntity? app;
  final double? xPadding;
  final double? yPadding;
  final double? titleSize;
  final double? subtitleSize;
  final bool? hasOptionsBtn;
  final Color? bgColor;
  final Color? titleColor;
  final Function()? onTap;
  final Function()? onOptionTap;
  final Function()? onEditTap;
  final Function()? onDeleteTap;
  final int? maxLines;
  const AppListItem({
    Key? key,
    this.app,
    this.xPadding,
    this.yPadding,
    this.titleSize,
    this.subtitleSize,
    this.hasOptionsBtn = true,
    this.bgColor,
    this.titleColor,
    this.onTap,
    this.onOptionTap,
    this.onEditTap,
    this.onDeleteTap,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 18.h,
      ),
      child: KCard(
        xPadding: 0.w,
        yPadding: 0.h,
        color: bgColor ?? KColors.primary,
        radius: 20.r,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: xPadding ?? 12.w,
            vertical: yPadding ?? 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Hero(
                      tag: '${app?.id}',
                      child: AppListImage(
                        imageName: app?.iconName,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.h),
                          KBadge(
                            badgeText:
                                "${(app?.notifications == null) ? 0 : app?.notifications?.length} Notifications",
                            radius: 10.r,
                            textSize: subtitleSize ?? 12.sp,
                            badgeColor: KColors.primary.shade700,
                            textColor: KColors.secondary,
                            yPadding: 5.h,
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            app?.name ?? '',
                            maxLines: maxLines ?? 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: titleColor ?? KColors.primary.shade200,
                              fontWeight: FontWeight.bold,
                              fontSize: titleSize ?? 18.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              hasOptionsBtn == true
                  ? GestureDetector(
                      onTap: onOptionTap,
                      child: KMenu(
                        items: [
                          kMenuItem(
                            title: 'Edit',
                            icon: Icons.edit_rounded,
                            onPressed: onEditTap ?? () {},
                          ),
                          kMenuItem(
                            title: 'Delete',
                            icon: Icons.delete_rounded,
                            itemColor: Colors.red,
                            onPressed: onDeleteTap ?? () {},
                          ),
                        ],
                        child: Icon(
                          Icons.more_vert_outlined,
                          color: KColors.primaryLight,
                        ),
                      ),
                    )
                  : const SizedBox(),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.more_vert_outlined,
              //     color: Colors.white,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
