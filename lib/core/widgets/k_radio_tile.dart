import 'package:fcm_notification/core/constants/constants.dart';
import 'package:flutter/material.dart';

class KRadioTile extends StatelessWidget {
  final Object value;
  final String title;
  final String? subtitle;
  final IconData icon;
  final Object? groupValue;
  final dynamic Function(Object?)? onChanged;
  const KRadioTile({
    Key? key,
    required this.value,
    required this.title,
    this.subtitle,
    required this.icon,
    this.groupValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: value,
      groupValue: groupValue,
      controlAffinity: ListTileControlAffinity.trailing,
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.amber,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
      subtitle: subtitle != null
          ? Padding(
              padding: EdgeInsets.only(top: 3.5.h),
              child: Text(
                subtitle ?? '',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  color: KColors.grey,
                ),
              ),
            )
          : null,
      secondary: Icon(
        icon,
        color: KColors.secondary,
      ),
      dense: true,
      activeColor: Colors.amber,
      enableFeedback: true,
      visualDensity: VisualDensity.compact,
      onChanged: onChanged,
    );
  }
}
