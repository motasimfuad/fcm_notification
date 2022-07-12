import 'package:flutter/material.dart';

class KFab extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onPressed;
  const KFab({
    Key? key,
    this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: FloatingActionButton.extended(
        elevation: 3.5,
        onPressed: onPressed,
        tooltip: label,
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        label: Text(label),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
