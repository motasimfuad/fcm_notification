import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import 'package:fcm_notification/core/constants/colors.dart';

class KMenu extends StatelessWidget {
  final Widget child;
  final List<FocusedMenuItem> items;
  const KMenu({
    Key? key,
    required this.child,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      menuWidth: 180,
      blurSize: 0.0,
      menuItemExtent: 50.h,
      menuBoxDecoration: BoxDecoration(
        color: KColors.primary,
        borderRadius: BorderRadius.circular(15.r),
      ),
      duration: const Duration(milliseconds: 30),
      animateMenuItems: false,
      blurBackgroundColor: Colors.black54,
      openWithTap: true,
      menuOffset: 10.w,
      bottomOffsetHeight: 80.h,
      onPressed: () {},
      menuItems: items,
      child: child,
    );
  }
}

FocusedMenuItem kMenuItem({
  required String title,
  required Function onPressed,
  IconData? icon,
  Color? itemColor,
  Color? bgColor,
}) {
  return FocusedMenuItem(
    title: Expanded(
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: itemColor ?? KColors.grey,
        ),
      ),
    ),
    trailingIcon: Icon(
      icon ?? Icons.delete,
      color: itemColor ?? KColors.grey,
      size: 18.w,
    ),
    backgroundColor: bgColor ?? KColors.primary,
    onPressed: onPressed,
  );
}
