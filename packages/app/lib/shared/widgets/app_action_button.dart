import 'package:app/core/theme/app_color_set.dart';
import 'package:flutter/material.dart';

enum ActionButtonType { primary, destructive }

class AppActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? customDefaultIconColor;
  final Color? customHoverIconColor;
  final Color? customHoverBackgroundColor;
  final ActionButtonType type;

  const AppActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.customDefaultIconColor,
    this.customHoverIconColor,
    this.customHoverBackgroundColor,
    this.type = ActionButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final defaultIconColor =
        customDefaultIconColor ?? context.colors.iconDefault;

    final hoverIconColor =
        customHoverIconColor ??
        (type == ActionButtonType.destructive
            ? context.colors.error
            : context.colors.iconActive);

    final hoverBackgroundColor =
        customHoverBackgroundColor ??
        (type == ActionButtonType.destructive
            ? context.colors.errorLight.withValues(alpha: 0.2)
            : context.colors.primaryLight.withValues(alpha: 0.05));

    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
        iconColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered)) {
            return hoverIconColor;
          }
          return defaultIconColor;
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered)) {
            return hoverBackgroundColor;
          }
          return Colors.transparent;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
          return Colors.transparent;
        }),
      ),
      icon: Icon(icon, size: 18),
      // splashRadius: 20,
    );
  }
}
