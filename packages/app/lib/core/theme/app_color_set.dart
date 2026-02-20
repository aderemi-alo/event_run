import 'package:flutter/material.dart';

class AppColorSet {
  final Brightness brightness;

  // ── Brand / Primary ───────────────────────────────────
  final Color primary; // buttons, links, progress bars
  final Color primaryLight; // focus rings, checkmarks
  final Color primaryDark; // hover state
  final Color primaryDarker; // pressed state
  final Color primarySurface; // selected card bg, pill buttons
  final Color primarySurfaceAlt; // subtle highlights

  // ── Text ──────────────────────────────────────────────
  final Color textPrimary; // headings
  final Color textSecondary; // body, feature lists
  final Color textTertiary; // subtitles, captions
  final Color textHint; // input placeholders
  final Color textDisabled;

  // ── Borders & Dividers ────────────────────────────────
  final Color border; // input borders
  final Color borderLight; // card borders, dividers
  final Color divider;

  // ── Surfaces ──────────────────────────────────────────
  final Color surfacePrimary; // cards, inputs
  final Color surfaceSecondary; // page backgrounds
  final Color surfaceTertiary; // placeholder areas

  // ── Icons ─────────────────────────────────────────────
  final Color iconDefault; // prefix icons, inactive
  final Color iconActive;

  // ── Semantic ──────────────────────────────────────────
  final Color error;
  final Color errorLight;
  final Color success;
  final Color successLight;
  final Color warning;
  final Color warningLight;
  final Color info;
  final Color infoLight;
  final Color infoBorder;

  // ── Shadows / Overlays ────────────────────────────────
  final Color shadow;
  final Color shadowPrimary;
  final Color overlay;

  // ── Button States ─────────────────────────────────────
  final Color buttonDisabledBg;
  final Color buttonDisabledFg;

  // ── On-color (content on colored backgrounds) ─────────
  final Color onPrimary;
  final Color onError;
  final Color mode;
  final Color onMode;

  const AppColorSet({
    required this.brightness,
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
    required this.mode,
    required this.onMode,
  });

  static const light = AppColorSet(
    brightness: Brightness.light,
    primary: Color(0xFF00897B),
    primaryLight: Color(0xFF009688),
    primaryDark: Color(0xFF00796B),
    primaryDarker: Color(0xFF00695C),
    primarySurface: Color(0xFFE0F2F1),
    primarySurfaceAlt: Color(0xFFB2DFDB),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textTertiary: Color(0xFF64748B),
    textHint: Color(0xFF94A3B8),
    textDisabled: Color(0xFFBDBDBD),
    border: Color(0xFFCBD5E1),
    borderLight: Color(0xFFE2E8F0),
    divider: Color(0xFFE2E8F0),
    surfacePrimary: Colors.white,
    surfaceSecondary: Color(0xFFF8FAFC),
    surfaceTertiary: Color(0xFFF1F5F9),
    iconDefault: Color(0xFF94A3B8),
    iconActive: Color(0xFF00897B),
    error: Color(0xFFDC2626),
    errorLight: Color(0xFFFEE2E2),
    success: Color(0xFF16A34A),
    successLight: Color(0xFFDCFCE7),
    warning: Color(0xFFF59E0B),
    warningLight: Color(0xFFFEF3C7),
    info: Color(0xFF2563EB),
    infoLight: Color(0xFFEFF6FF),
    infoBorder: Color(0xFFDBEAFE),
    shadow: Color(0x0A000000),
    shadowPrimary: Color(0x4000897B),
    overlay: Color(0x1F000000),
    buttonDisabledBg: Color(0xFFE0E0E0),
    buttonDisabledFg: Color(0xFFBDBDBD),
    onPrimary: Colors.white,
    onError: Colors.white,
    mode: Color(0xFFFFFFFF),
    onMode: Color(0xFF000000),
  );

  static const dark = AppColorSet(
    brightness: Brightness.dark,
    primary: Color(0xFF26A69A),
    primaryLight: Color(0xFF4DB6AC),
    primaryDark: Color(0xFF00897B),
    primaryDarker: Color(0xFF00796B),
    primarySurface: Color(0xFF0D2E2A),
    primarySurfaceAlt: Color(0xFF133B36),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFFCBD5E1),
    textTertiary: Color(0xFF94A3B8),
    textHint: Color(0xFF64748B),
    textDisabled: Color(0xFF475569),
    border: Color(0xFF334155),
    borderLight: Color(0xFF1E293B),
    divider: Color(0xFF1E293B),
    surfacePrimary: Color(0xFF1E293B),
    surfaceSecondary: Color(0xFF0F172A),
    surfaceTertiary: Color(0xFF334155),
    iconDefault: Color(0xFF64748B),
    iconActive: Color(0xFF26A69A),
    error: Color(0xFFF87171),
    errorLight: Color(0xFF3B1C1C),
    success: Color(0xFF4ADE80),
    successLight: Color(0xFF14332A),
    warning: Color(0xFFFBBF24),
    warningLight: Color(0xFF332B14),
    info: Color(0xFF60A5FA),
    infoLight: Color(0xFF172554),
    infoBorder: Color(0xFF1E3A5F),
    shadow: Color(0x40000000),
    shadowPrimary: Color(0x6626A69A),
    overlay: Color(0x66000000),
    buttonDisabledBg: Color(0xFF334155),
    buttonDisabledFg: Color(0xFF64748B),
    onPrimary: Color(0xFF0F172A),
    onError: Color(0xFF0F172A),
    mode: Color(0xFF000000),
    onMode: Color(0xFFFFFFFF),
  );
}

extension AppColorsX on BuildContext {
  AppColorSet get colors => Theme.of(this).brightness == Brightness.dark
      ? AppColorSet.dark
      : AppColorSet.light;
}
