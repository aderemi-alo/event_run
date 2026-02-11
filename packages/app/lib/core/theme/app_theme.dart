import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

// ============================================================
// EventRun Theme
// ============================================================

abstract final class AppTheme {
  // ── Shared radii ──────────────────────────────────────
  static const _inputRadius = 8.0;
  static const _cardRadius = 16.0;
  static const _buttonRadius = 12.0;

  static final _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(_buttonRadius),
  );

  static const _buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 14,
  );

  static const _buttonTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontVariations: [FontVariation('wght', 600)],
  );

  // ═════════════════════════════════════════════════════════
  // LIGHT THEME
  // ═════════════════════════════════════════════════════════
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.surfaceSecondary,
    textTheme: AppTypography.textTheme,

    // ── Color Scheme ─────────────────────────────────
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primarySurface,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.textSecondary,
      onSecondary: Colors.white,
      surface: AppColors.surfacePrimary,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceTertiary,
      outline: AppColors.border,
      outlineVariant: AppColors.borderLight,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorLight,
    ),

    dividerColor: AppColors.divider,
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // ── App Bar ──────────────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfacePrimary,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    ),

    // ── Card ─────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.surfacePrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
        side: const BorderSide(color: AppColors.borderLight),
      ),
      margin: EdgeInsets.zero,
    ),

    // ── Input Decoration ─────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
      prefixIconColor: AppColors.iconDefault,
      suffixIconColor: AppColors.iconDefault,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
    ),

    // ── Elevated Button (primary) ────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.buttonDisabledBg;
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryDarker;
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primaryDark;
          }
          return AppColors.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.buttonDisabledFg;
          }
          return AppColors.onPrimary;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.white.withValues(alpha: .12);
          }
          if (states.contains(WidgetState.hovered)) {
            return Colors.white.withValues(alpha: .04);
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return 0;
          if (states.contains(WidgetState.pressed)) return 1;
          if (states.contains(WidgetState.hovered)) return 6;
          return 2;
        }),
        shadowColor: const WidgetStatePropertyAll(AppColors.shadowPrimary),
        shape: WidgetStatePropertyAll(_buttonShape),
        padding: const WidgetStatePropertyAll(_buttonPadding),
        textStyle: const WidgetStatePropertyAll(_buttonTextStyle),
        animationDuration: const Duration(milliseconds: 150),
      ),
    ),

    // ── Outlined Button (secondary) ──────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return Colors.transparent;
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primary.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primary.withValues(alpha: 0.04);
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.buttonDisabledFg;
          }
          return AppColors.primary;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return const BorderSide(color: AppColors.borderLight, width: 1.5);
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return const BorderSide(color: AppColors.primaryDark, width: 1.5);
          }
          return const BorderSide(color: AppColors.primary, width: 1.5);
        }),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(_buttonShape),
        padding: const WidgetStatePropertyAll(_buttonPadding),
        textStyle: const WidgetStatePropertyAll(_buttonTextStyle),
        animationDuration: const Duration(milliseconds: 150),
      ),
    ),

    // ── Text Button (ghost) ──────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primary.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primary.withValues(alpha: 0.04);
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.buttonDisabledFg;
          }
          return AppColors.primary;
        }),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(_buttonShape),
        padding: const WidgetStatePropertyAll(_buttonPadding),
        textStyle: const WidgetStatePropertyAll(_buttonTextStyle),
        animationDuration: const Duration(milliseconds: 150),
      ),
    ),

    // ── Progress Indicator ───────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.borderLight,
      circularTrackColor: AppColors.borderLight,
    ),

    // ── Checkbox ─────────────────────────────────────
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return Colors.transparent;
      }),
      checkColor: const WidgetStatePropertyAll(Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: const BorderSide(color: AppColors.border, width: 1.5),
    ),

    // ── Radio ────────────────────────────────────────
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.border;
      }),
    ),

    // ── Switch ───────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.iconDefault;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primarySurface;
        }
        return AppColors.borderLight;
      }),
    ),

    // ── Snack Bar ────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),

    // ── Bottom Sheet ─────────────────────────────────
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surfacePrimary,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // ── Dialog ───────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surfacePrimary,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
    ),

    // ── Chip (status badges, filters) ────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceTertiary,
      selectedColor: AppColors.primarySurface,
      disabledColor: AppColors.surfaceTertiary,
      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),

    // ── FAB ──────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // ── Tab Bar ──────────────────────────────────────
    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textTertiary,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
    ),
  );

  // ═════════════════════════════════════════════════════════
  // DARK THEME (scaffold — extend as you build out)
  // ═════════════════════════════════════════════════════════
  static final ThemeData dark = light.copyWith(
    brightness: Brightness.dark,
    textTheme: AppTypography.darkTextTheme,
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryLight,
      onPrimary: AppColors.onPrimary,
      primaryContainer: Color(0xFF004D40),
      onPrimaryContainer: AppColors.primarySurface,
      surface: Color(0xFF1E293B),
      onSurface: Color(0xFFF1F5F9),
      outline: Color(0xFF475569),
      outlineVariant: Color(0xFF334155),
      error: Color(0xFFF87171),
      onError: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E293B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
        side: const BorderSide(color: Color(0xFF334155)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F172A),
      foregroundColor: Color(0xFFF1F5F9),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
  );
}
