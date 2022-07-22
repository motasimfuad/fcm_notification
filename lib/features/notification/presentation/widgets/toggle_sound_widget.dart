import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/constants/constants.dart';

// ignore: must_be_immutable
class ToggleSoundWidget extends StatelessWidget {
  final int? initialLabelIndex;
  Function(int?)? onToggle;
  ToggleSoundWidget({
    Key? key,
    this.initialLabelIndex,
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Sound',
            style: TextStyle(
              fontSize: 16.sp,
              color: KColors.primary.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
          Semantics(
            container: true,
            child: ToggleSwitch(
              customWidths: [
                55.w,
                55.w,
              ],
              initialLabelIndex: 0,
              cornerRadius: 15.r,
              activeFgColor: KColors.primary,
              inactiveFgColor: KColors.primary.shade300,
              inactiveBgColor: KColors.primary.shade500,
              totalSwitches: 2,
              icons: const [
                Icons.volume_off,
                Icons.volume_up,
              ],
              iconSize: 20.w,
              activeBgColors: const [
                [KColors.secondary],
                [KColors.secondary],
              ],
              onToggle: onToggle,
            ),
          ),
        ],
      ),
    );
  }
}
