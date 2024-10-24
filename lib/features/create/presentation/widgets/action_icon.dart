import 'package:flutter/material.dart';
import 'package:refocus_app/core/core.dart' show kcSecondary200;

class ActionIcon extends StatelessWidget {
  const ActionIcon({Key? key, required this.icon, this.color, this.onTap})
      : super(key: key);

  final void Function()? onTap;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          icon,
          size: 24,
          color: color ?? kcSecondary200,
        ),
      ),
    );
  }
}
