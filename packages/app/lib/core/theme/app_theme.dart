import 'package:app/core/theme/app_color_set.dart';
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

  // ── Build Theme ──────────────────────────────────────
  static final ThemeData light = _build(AppColorSet.light, Brightness.light);
  static final ThemeData dark = _build(AppColorSet.dark, Brightness.dark);

  // ═════════════════════════════════════════════════════════
  // THEME
  // ═════════════════════════════════════════════════════════
  static ThemeData _build(AppColorSet c, Brightness brightness) => ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: c.surfaceSecondary,
    textTheme: AppTypography.textTheme,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,

    // ── Color Scheme ─────────────────────────────────
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.onPrimary,
      primaryContainer: c.primarySurface,
      onPrimaryContainer: c.primaryDark,
      secondary: c.textSecondary,
      onSecondary: c.mode,
      surface: c.surfacePrimary,
      onSurface: c.textPrimary,
      surfaceContainerHighest: c.surfaceTertiary,
      outline: c.border,
      outlineVariant: c.borderLight,
      error: c.error,
      onError: c.onError,
      errorContainer: c.errorLight,
    ),

    dividerColor: c.divider,
    dividerTheme: DividerThemeData(color: c.divider, thickness: 1, space: 1),

    // ── App Bar ──────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: c.surfacePrimary,
      foregroundColor: c.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    ),

    // ── Card ─────────────────────────────────────────
    cardTheme: CardThemeData(
      color: c.surfacePrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
        side: BorderSide(color: c.borderLight),
      ),
      margin: EdgeInsets.zero,
    ),

    // ── Input Decoration ─────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: TextStyle(color: c.textHint, fontSize: 14),
      prefixIconColor: c.iconDefault,
      suffixIconColor: c.iconDefault,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: c.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: c.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: c.primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: c.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: c.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_inputRadius),
        borderSide: BorderSide(color: c.borderLight),
      ),
    ),

    // ── Elevated Button (primary) ────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return c.buttonDisabledBg;
          }
          if (states.contains(WidgetState.pressed)) {
            return c.primaryDarker;
          }
          if (states.contains(WidgetState.hovered)) {
            return c.primaryDark;
          }
          return c.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return c.buttonDisabledFg;
          }
          return c.onPrimary;
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
        shadowColor: WidgetStatePropertyAll(c.shadowPrimary),
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
            return c.primary.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.hovered)) {
            return c.primary.withValues(alpha: 0.04);
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return c.buttonDisabledFg;
          }
          return c.primary;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: c.borderLight, width: 1.5);
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return BorderSide(color: c.primaryDark, width: 1.5);
          }
          return BorderSide(color: c.primary, width: 1.5);
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
            return c.primary.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.hovered)) {
            return c.primary.withValues(alpha: 0.04);
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return c.buttonDisabledFg;
          }
          return c.primary;
        }),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(_buttonShape),
        padding: const WidgetStatePropertyAll(_buttonPadding),
        textStyle: const WidgetStatePropertyAll(_buttonTextStyle),
        animationDuration: const Duration(milliseconds: 150),
      ),
    ),

    // ── Progress Indicator ───────────────────────────
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: c.primary,
      linearTrackColor: c.borderLight,
      circularTrackColor: c.borderLight,
    ),

    // ── Checkbox ─────────────────────────────────────
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return c.primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStatePropertyAll(Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: c.border, width: 1.5),
    ),

    // ── Radio ────────────────────────────────────────
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return c.primary;
        return c.border;
      }),
    ),

    // ── Switch ───────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return c.primary;
        return c.iconDefault;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return c.primarySurface;
        }
        return c.borderLight;
      }),
    ),

    // ── Snack Bar ────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: c.textPrimary,
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),

    // ── Bottom Sheet ─────────────────────────────────
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: c.surfacePrimary,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // ── Dialog ───────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: c.surfacePrimary,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
    ),

    // ── Chip (status badges, filters) ────────────────
    chipTheme: ChipThemeData(
      backgroundColor: c.surfaceTertiary,
      selectedColor: c.primarySurface,
      disabledColor: c.surfaceTertiary,
      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),

    // ── FAB ──────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: c.primary,
      foregroundColor: c.onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // ── Tab Bar ──────────────────────────────────────
    tabBarTheme: TabBarThemeData(
      labelColor: c.primary,
      unselectedLabelColor: c.textTertiary,
      indicatorColor: c.primary,
      indicatorSize: TabBarIndicatorSize.label,
    ),
  );
}
