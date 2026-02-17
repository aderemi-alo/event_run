// ============================================================
// EventRun Color System
// ============================================================
//
// Usage:
//   AppColors.primary
//   AppColors.textSecondary
//   AppColors.semantic.info
// ============================================================

import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Brand / Primary (Teal) ────────────────────────────
  static const Color primary = Color(
    0xFF00897B,
  ); // teal-600 — buttons, links, progress bars
  static const Color primaryLight = Color(
    0xFF009688,
  ); // teal-500 — focus rings, checkmarks
  static const Color primaryDark = Color(
    0xFF00796B,
  ); // teal-700 — hover, logo text
  static const Color primaryDarker = Color(
    0xFF00695C,
  ); // teal-800 — pressed state
  static const Color primarySurface = Color(
    0xFFE0F2F1,
  ); // teal-50  — selected card bg, pill buttons
  static const Color primarySurfaceAlt = Color(
    0xFFB2DFDB,
  ); // teal-100 — subtle highlights

  // ── Text ──────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF0F172A); // slate-900 — headings
  static const Color textSecondary = Color(
    0xFF475569,
  ); // slate-600 — body, feature lists
  static const Color textTertiary = Color(
    0xFF64748B,
  ); // slate-500 — subtitles, captions
  static const Color textHint = Color(
    0xFF94A3B8,
  ); // slate-400 — input placeholders
  static const Color textDisabled = Color(0xFFBDBDBD); // grey-400

  // ── Borders & Dividers ────────────────────────────────
  static const Color border = Color(0xFFCBD5E1); // slate-300 — input borders
  static const Color borderLight = Color(
    0xFFE2E8F0,
  ); // slate-200 — card borders, dividers
  static const Color divider = Color(0xFFE2E8F0); // slate-200

  // ── Surfaces ──────────────────────────────────────────
  static const Color surfacePrimary = Colors.white; // cards, inputs, signup bg
  static const Color surfaceSecondary = Color(
    0xFFF8FAFC,
  ); // slate-50  — page backgrounds (onboarding)
  static const Color surfaceTertiary = Color(
    0xFFF1F5F9,
  ); // slate-100 — placeholder areas (logo circle)

  // ── Icons ─────────────────────────────────────────────
  static const Color iconDefault = Color(
    0xFF94A3B8,
  ); // slate-400 — prefix icons, inactive
  static const Color iconActive = Color(0xFF00897B); // primary

  // ── Semantic ──────────────────────────────────────────
  static const Color error = Color(0xFFDC2626); // red-600
  static const Color errorLight = Color(0xFFFEE2E2); // red-100
  static const Color success = Color(0xFF16A34A); // green-600
  static const Color successLight = Color(0xFFDCFCE7); // green-100
  static const Color warning = Color(0xFFF59E0B); // amber-500
  static const Color warningLight = Color(0xFFFEF3C7); // amber-100
  static const Color info = Color(0xFF2563EB); // blue-600 — info banner icon
  static const Color infoLight = Color(0xFFEFF6FF); // blue-50  — info banner bg
  static const Color infoBorder = Color(
    0xFFDBEAFE,
  ); // blue-100 — info banner border

  // ── Shadows / Overlays ────────────────────────────────
  static const Color shadow = Color(0x0A000000); // black 4%  — card box shadow
  static const Color shadowPrimary = Color(
    0x4000897B,
  ); // teal 25%  — button shadow
  static const Color overlay = Color(0x1F000000); // black 12% — modal scrim

  // ── Button States ─────────────────────────────────────
  static const Color buttonDisabledBg = Color(0xFFE0E0E0);
  static const Color buttonDisabledFg = Color(0xFFBDBDBD);

  // ── On-color (content on colored backgrounds) ─────────
  static const Color onPrimary = Colors.white;
  static const Color onError = Colors.white;

  static const Color onMode = Color(0xFF000000);
  static const Color mode = Color(0xFFFFFFFF);
}

abstract final class AppDarkColors {
  // ── Brand / Primary (Teal — slightly lifted for dark bg contrast) ──
  static const Color primary = Color(0xFF26A69A); // teal-400 — buttons, links
  static const Color primaryLight = Color(
    0xFF4DB6AC,
  ); // teal-300 — focus rings, checkmarks
  static const Color primaryDark = Color(0xFF00897B); // teal-600 — hover
  static const Color primaryDarker = Color(
    0xFF00796B,
  ); // teal-700 — pressed state
  static const Color primarySurface = Color(
    0xFF0D2E2A,
  ); // teal-950ish — selected card bg, pill buttons
  static const Color primarySurfaceAlt = Color(
    0xFF133B36,
  ); // teal-900ish — subtle highlights

  // ── Text ──────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF1F5F9); // slate-100 — headings
  static const Color textSecondary = Color(
    0xFFCBD5E1,
  ); // slate-300 — body, feature lists
  static const Color textTertiary = Color(
    0xFF94A3B8,
  ); // slate-400 — subtitles, captions
  static const Color textHint = Color(
    0xFF64748B,
  ); // slate-500 — input placeholders
  static const Color textDisabled = Color(0xFF475569); // slate-600

  // ── Borders & Dividers ────────────────────────────────
  static const Color border = Color(0xFF334155); // slate-700 — input borders
  static const Color borderLight = Color(
    0xFF1E293B,
  ); // slate-800 — card borders, dividers
  static const Color divider = Color(0xFF1E293B); // slate-800

  // ── Surfaces ──────────────────────────────────────────
  static const Color surfacePrimary = Color(
    0xFF1E293B,
  ); // slate-800 — cards, inputs
  static const Color surfaceSecondary = Color(
    0xFF0F172A,
  ); // slate-900 — page backgrounds
  static const Color surfaceTertiary = Color(
    0xFF334155,
  ); // slate-700 — placeholder areas

  // ── Icons ─────────────────────────────────────────────
  static const Color iconDefault = Color(
    0xFF64748B,
  ); // slate-500 — prefix icons, inactive
  static const Color iconActive = Color(0xFF26A69A); // primary

  // ── Semantic ──────────────────────────────────────────
  static const Color error = Color(0xFFF87171); // red-400
  static const Color errorLight = Color(0xFF3B1C1C); // dark red surface
  static const Color success = Color(0xFF4ADE80); // green-400
  static const Color successLight = Color(0xFF14332A); // dark green surface
  static const Color warning = Color(0xFFFBBF24); // amber-400
  static const Color warningLight = Color(0xFF332B14); // dark amber surface
  static const Color info = Color(0xFF60A5FA); // blue-400
  static const Color infoLight = Color(0xFF172554); // blue-950 — info banner bg
  static const Color infoBorder = Color(0xFF1E3A5F); // dark blue border

  // ── Shadows / Overlays ────────────────────────────────
  static const Color shadow = Color(
    0x40000000,
  ); // black 25% — more visible on dark
  static const Color shadowPrimary = Color(0x6626A69A); // teal 40%
  static const Color overlay = Color(0x66000000); // black 40% — modal scrim

  // ── Button States ─────────────────────────────────────
  static const Color buttonDisabledBg = Color(0xFF334155); // slate-700
  static const Color buttonDisabledFg = Color(0xFF64748B); // slate-500

  // ── On-color (content on colored backgrounds) ─────────
  static const Color onPrimary = Color(
    0xFF0F172A,
  ); // slate-900 — dark text on teal
  static const Color onError = Color(0xFF0F172A);

  static const Color mode = Color(0xFF000000);
  static const Color onMode = Color(0xFFFFFFFF);
}
