import 'package:app/core/theme/app_color_set.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final Widget? labelWidget;
  final IconData? icon;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? suffix;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Iterable<String>? autofillHints;

  const AppTextField({
    super.key,
    this.label,
    this.labelWidget,
    this.icon,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.validator,
    this.isPassword = false,
    this.suffix,
    this.prefix,
    this.inputFormatters,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofillHints,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelWidget ??
            (widget.label != null
                ? Text(
                    widget.label!,
                    style: textTheme.labelLarge?.vCopyWith(
                      fontWeight: AppFontWeight.medium,
                      color: context.appColors.textSecondary,
                    ),
                  )
                : const SizedBox.shrink()),
        const SizedBox(height: 6),
        TextFormField(
          autofillHints: widget.autofillHints,
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? obscureText : false,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: textTheme.bodyMedium?.vCopyWith(
              color: context.appColors.textHint,
            ),
            prefixIcon: widget.prefix != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Icon(
                            widget.icon,
                            color: context.appColors.textHint,
                            size: 20,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: widget.prefix!,
                      ),
                    ],
                  )
                : widget.icon != null
                ? Icon(widget.icon, color: context.appColors.textHint, size: 20)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : widget.suffix,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
