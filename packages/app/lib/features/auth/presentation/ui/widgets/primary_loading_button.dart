import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryLoadingButton extends StatelessWidget {
  const PrimaryLoadingButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.width = double.infinity,
    this.hoverColor,
    this.hapticFeedback,
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;
  final IconData? icon;
  final Color? backgroundColor, hoverColor;
  final double width;
  final Future<void>? hapticFeedback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = backgroundColor ?? theme.colorScheme.primary;
    final isDisabled = isLoading || onPressed == null;

    return Opacity(
      opacity: isDisabled ? 0.7 : 1.0,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: effectiveColor.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Semantics(
          button: true,
          enabled: !isDisabled,
          label: label,
          value: isLoading ? 'Loading' : null,
          hint: isDisabled
              ? (isLoading ? 'Please wait' : 'Disabled')
              : 'Double tap to activate',
          child: Material(
            color: effectiveColor,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              splashColor: null,
              highlightColor: null,
              overlayColor: null,
              onTap: isDisabled
                  ? null
                  : () {
                      hapticFeedback ?? HapticFeedback.lightImpact();
                      onPressed!();
                    },
              hoverColor:
                  hoverColor ?? Color.lerp(effectiveColor, Colors.black, 0.12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 24,
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isLoading ? _buildLoader() : _buildContent(theme),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return const SizedBox(
      key: ValueKey('loader'),
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    return Row(
      key: const ValueKey('content'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        if (icon != null) ...[
          const SizedBox(width: 8),
          Icon(icon, size: 20, color: Colors.white),
        ],
      ],
    );
  }
}
