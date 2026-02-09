import 'package:flutter/material.dart';
import 'package:event_run/core/constants/app_colors.dart';
import 'package:event_run/core/constants/app_spacing.dart';

/// Reusable text field for auth forms (Tailwind-like styling)
class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.isPassword = false,
    this.prefixIcon,
    this.enabled = true,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofillHints,
    this.showLabel = true,
    super.key,
  });

  final TextEditingController controller;
  final String label;

  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool isPassword;
  final IconData? prefixIcon;
  final bool enabled;

  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Iterable<String>? autofillHints;

  /// Set false when you want to render the label yourself (e.g. Password + Forgot link row)
  final bool showLabel;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  void didUpdateWidget(covariant AuthTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If isPassword changes, keep behavior consistent
    if (oldWidget.isPassword != widget.isPassword) {
      _obscure = widget.isPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
      color: AppColors.slate700,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel && widget.label.trim().isNotEmpty) ...[
          Text(widget.label, style: labelStyle),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          obscureText: widget.isPassword ? _obscure : false,
          enabled: widget.enabled,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          autofillHints: widget.autofillHints,
          decoration: InputDecoration(
            hintText: widget.hintText,

            // Tailwind: pl-10 (icon space) + muted icon color
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.slate400)
                : null,

            // Password toggle (optional)
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.slate400,
                    ),
                    tooltip: _obscure ? 'Show password' : 'Hide password',
                  )
                : null,

            // Tailwind-ish padding
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),

            // Tailwind: border border-slate-200 rounded-xl
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.slate200),
            ),

            // Tailwind: focus:ring-2 focus:ring-teal-500 focus:border-transparent
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.teal.shade500, width: 2),
            ),

            // Errors
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade400),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade400, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
