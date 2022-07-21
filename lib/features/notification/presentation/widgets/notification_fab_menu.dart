import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

import '../../../../core/constants/colors.dart';

class NotificationFabMenu extends StatelessWidget {
  final Widget child;
  final Function onTapDelete;
  final Function onTapDuplicate;
  final Function onTapEdit;
  final Function onTapSend;
  const NotificationFabMenu({
    Key? key,
    required this.child,
    required this.onTapDelete,
    required this.onTapDuplicate,
    required this.onTapEdit,
    required this.onTapSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HawkFabMenu(
      icon: AnimatedIcons.menu_close,
      fabColor: KColors.secondary,
      iconColor: KColors.primary,
      blur: 5.0,
      backgroundColor: KColors.background.withOpacity(0.6),
      items: [
        HawkFabMenuItem(
          label: 'Delete',
          ontap: onTapDelete,
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: Colors.red,
          ),
          color: KColors.primary.shade400,
          labelColor: KColors.primary.shade200,
          labelBackgroundColor: KColors.primary.shade400,
        ),
        HawkFabMenuItem(
          label: 'Edit',
          ontap: onTapEdit,
          icon: const Icon(
            Icons.edit_note_rounded,
            color: KColors.info,
          ),
          color: KColors.primary.shade400,
          labelColor: KColors.primary.shade200,
          labelBackgroundColor: KColors.primary.shade400,
        ),
        HawkFabMenuItem(
          label: 'Duplicate',
          ontap: onTapDuplicate,
          icon: const Icon(
            Icons.copy_all_rounded,
            color: KColors.success,
          ),
          color: KColors.primary.shade400,
          labelColor: KColors.primary.shade200,
          labelBackgroundColor: KColors.primary.shade400,
        ),
        HawkFabMenuItem(
          label: 'Send Notification',
          ontap: onTapSend,
          icon: const Icon(
            Icons.send_rounded,
            color: KColors.secondary,
          ),
          color: KColors.primary.shade400,
          labelColor: KColors.primary.shade200,
          labelBackgroundColor: KColors.primary.shade400,
        ),
      ],
      body: child,
    );
  }
}
