import 'package:app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppColorSet {
  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color primaryDarker;
  final Color primarySurface;
  final Color primarySurfaceAlt;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textHint;
  final Color textDisabled;
  final Color border;
  final Color borderLight;
  final Color divider;
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceTertiary;
  final Color iconDefault;
  final Color iconActive;
  final Color error;
  final Color errorLight;
  final Color success;
  final Color successLight;
  final Color warning;
  final Color warningLight;
  final Color info;
  final Color infoLight;
  final Color infoBorder;
  final Color shadow;
  final Color shadowPrimary;
  final Color overlay;
  final Color buttonDisabledBg;
  final Color buttonDisabledFg;
  final Color onPrimary;
  final Color onError;

  const AppColorSet({
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.primaryDarker,
    required this.primarySurface,
    required this.primarySurfaceAlt,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textHint,
    required this.textDisabled,
    required this.border,
    required this.borderLight,
    required this.divider,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.surfaceTertiary,
    required this.iconDefault,
    required this.iconActive,
    required this.error,
    required this.errorLight,
    required this.success,
    required this.successLight,
    required this.warning,
    required this.warningLight,
    required this.info,
    required this.infoLight,
    required this.infoBorder,
    required this.shadow,
    required this.shadowPrimary,
    required this.overlay,
    required this.buttonDisabledBg,
    required this.buttonDisabledFg,
    required this.onPrimary,
    required this.onError,
  });

  static const light = AppColorSet(
    primary: AppColors.primary,
    primaryLight: AppColors.primaryLight,
    primaryDark: AppColors.primaryDark,
    primaryDarker: AppColors.primaryDarker,
    primarySurface: AppColors.primarySurface,
    primarySurfaceAlt: AppColors.primarySurfaceAlt,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textTertiary: AppColors.textTertiary,
    textHint: AppColors.textHint,
    textDisabled: AppColors.textDisabled,
    border: AppColors.border,
    borderLight: AppColors.borderLight,
    divider: AppColors.divider,
    surfacePrimary: AppColors.surfacePrimary,
    surfaceSecondary: AppColors.surfaceSecondary,
    surfaceTertiary: AppColors.surfaceTertiary,
    iconDefault: AppColors.iconDefault,
    iconActive: AppColors.iconActive,
    error: AppColors.error,
    errorLight: AppColors.errorLight,
    success: AppColors.success,
    successLight: AppColors.successLight,
    warning: AppColors.warning,
    warningLight: AppColors.warningLight,
    info: AppColors.info,
    infoLight: AppColors.infoLight,
    infoBorder: AppColors.infoBorder,
    shadow: AppColors.shadow,
    shadowPrimary: AppColors.shadowPrimary,
    overlay: AppColors.overlay,
    buttonDisabledBg: AppColors.buttonDisabledBg,
    buttonDisabledFg: AppColors.buttonDisabledFg,
    onPrimary: AppColors.onPrimary,
    onError: AppColors.onError,
  );

  static const dark = AppColorSet(
    primary: AppDarkColors.primary,
    primaryLight: AppDarkColors.primaryLight,
    primaryDark: AppDarkColors.primaryDark,
    primaryDarker: AppDarkColors.primaryDarker,
    primarySurface: AppDarkColors.primarySurface,
    primarySurfaceAlt: AppDarkColors.primarySurfaceAlt,
    textPrimary: AppDarkColors.textPrimary,
    textSecondary: AppDarkColors.textSecondary,
    textTertiary: AppDarkColors.textTertiary,
    textHint: AppDarkColors.textHint,
    textDisabled: AppDarkColors.textDisabled,
    border: AppDarkColors.border,
    borderLight: AppDarkColors.borderLight,
    divider: AppDarkColors.divider,
    surfacePrimary: AppDarkColors.surfacePrimary,
    surfaceSecondary: AppDarkColors.surfaceSecondary,
    surfaceTertiary: AppDarkColors.surfaceTertiary,
    iconDefault: AppDarkColors.iconDefault,
    iconActive: AppDarkColors.iconActive,
    error: AppDarkColors.error,
    errorLight: AppDarkColors.errorLight,
    success: AppDarkColors.success,
    successLight: AppDarkColors.successLight,
    warning: AppDarkColors.warning,
    warningLight: AppDarkColors.warningLight,
    info: AppDarkColors.info,
    infoLight: AppDarkColors.infoLight,
    infoBorder: AppDarkColors.infoBorder,
    shadow: AppDarkColors.shadow,
    shadowPrimary: AppDarkColors.shadowPrimary,
    overlay: AppDarkColors.overlay,
    buttonDisabledBg: AppDarkColors.buttonDisabledBg,
    buttonDisabledFg: AppDarkColors.buttonDisabledFg,
    onPrimary: AppDarkColors.onPrimary,
    onError: AppDarkColors.onError,
  );
}

extension AppColorsX on BuildContext {
  AppColorSet get appColors => Theme.of(this).brightness == Brightness.dark
      ? AppColorSet.dark
      : AppColorSet.light;
}
