import 'package:fcm_notification/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? height;
  final double? elevation;
  final Widget? content;
  final Color? color;
  final Color? titleColor;
  final IconData? actionBtn;
  final Function()? onActionPress;
  final PreferredSizeWidget? bottom;
  const KAppbar({
    Key? key,
    required this.title,
    this.height,
    this.elevation,
    this.content,
    this.color,
    this.titleColor,
    this.actionBtn,
    this.onActionPress,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: content != null
          ? Container(
              child: content,
            )
          : Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.w600,
              ),
            ),
      elevation: elevation ?? 0,
      backgroundColor: color ?? KColors.background,
      centerTitle: true,
      toolbarHeight: height ?? 55.h,
      actions: [
        actionBtn != null
            ? IconButton(
                onPressed: onActionPress,
                icon: Icon(actionBtn),
                padding: EdgeInsets.only(right: 20.w),
              )
            : const SizedBox(),
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 55.h);
}
