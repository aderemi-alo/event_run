import 'dart:ui';

import 'package:flutter/material.dart';

// ============================================================
// EventRun Typography System
// ============================================================
//
// SETUP:
// 1. Download the variable font file from Google Fonts:
//    https://fonts.google.com/specimen/Plus+Jakarta+Sans
//    (or whichever font you choose — just swap the family name)
//
// 2. Place it in: assets/fonts/PlusJakartaSans-VariableFont_wght.ttf
//
// 3. Register in pubspec.yaml:
//    flutter:
//      fonts:
//        - family: PlusJakartaSans
//          fonts:
//            - asset: assets/fonts/PlusJakartaSans-VariableFont_wght.ttf
//
// 4. Use in your app:
//    MaterialApp(
//      theme: ThemeData(
//        textTheme: AppTypography.textTheme,
//        // or for dark mode:
//        // textTheme: AppTypography.darkTextTheme,
//      ),
//    )
//
// 5. In widgets, use vCopyWith instead of copyWith:
//    Text(
//      'Hello',
//      style: Theme.of(context).textTheme.bodyLarge?.vCopyWith(
//        fontWeight: FontWeight.w700,
//        color: Colors.red,
//      ),
//    )
// ============================================================

/// Font family constant — change this once if you swap fonts.
const String _fontFamily = 'Inter';

// ============================================================
// Font Weights
// ============================================================
/// Semantic weight aliases for consistency across the app.
abstract final class AppFontWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

// ============================================================
// Font Sizes
// ============================================================
abstract final class AppFontSize {
  static const double displayLarge = 40.0;
  static const double displayMedium = 34.0;
  static const double displaySmall = 28.0;

  static const double headlineLarge = 24.0;
  static const double headlineMedium = 20.0;
  static const double headlineSmall = 18.0;

  static const double titleLarge = 18.0;
  static const double titleMedium = 16.0;
  static const double titleSmall = 14.0;

  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;

  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 11.0;
}

// ============================================================
// Core Style Builder
// ============================================================
TextStyle _baseStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required double height,
  double letterSpacing = 0.0,
}) => TextStyle(
  fontFamily: _fontFamily,
  fontSize: fontSize,
  fontWeight: fontWeight,
  height: height,
  letterSpacing: letterSpacing,
  fontVariations: [FontVariation('wght', fontWeight.value.toDouble())],
);

// ============================================================
// Text Theme
// ============================================================
abstract final class AppTypography {
  /// Light / default text theme.
  static final TextTheme textTheme = _buildTextTheme();

  /// Dark text theme (same styles, just applied on dark surfaces).
  static final TextTheme darkTextTheme = _buildTextTheme();

  static TextTheme _buildTextTheme() => TextTheme(
    // ----- Display -----
    displayLarge: _baseStyle(
      fontSize: AppFontSize.displayLarge,
      fontWeight: AppFontWeight.bold,
      height: 1.2,
      letterSpacing: -0.5,
    ),
    displayMedium: _baseStyle(
      fontSize: AppFontSize.displayMedium,
      fontWeight: AppFontWeight.bold,
      height: 1.2,
      letterSpacing: -0.25,
    ),
    displaySmall: _baseStyle(
      fontSize: AppFontSize.displaySmall,
      fontWeight: AppFontWeight.semiBold,
      height: 1.25,
    ),

    // ----- Headline -----
    headlineLarge: _baseStyle(
      fontSize: AppFontSize.headlineLarge,
      fontWeight: AppFontWeight.semiBold,
      height: 1.3,
    ),
    headlineMedium: _baseStyle(
      fontSize: AppFontSize.headlineMedium,
      fontWeight: AppFontWeight.semiBold,
      height: 1.3,
    ),
    headlineSmall: _baseStyle(
      fontSize: AppFontSize.headlineSmall,
      fontWeight: AppFontWeight.semiBold,
      height: 1.35,
    ),

    // ----- Title (app bars, cards, dialogs) -----
    titleLarge: _baseStyle(
      fontSize: AppFontSize.titleLarge,
      fontWeight: AppFontWeight.semiBold,
      height: 1.35,
    ),
    titleMedium: _baseStyle(
      fontSize: AppFontSize.titleMedium,
      fontWeight: AppFontWeight.medium,
      height: 1.4,
      letterSpacing: 0.15,
    ),
    titleSmall: _baseStyle(
      fontSize: AppFontSize.titleSmall,
      fontWeight: AppFontWeight.medium,
      height: 1.4,
      letterSpacing: 0.1,
    ),

    // ----- Body (main content) -----
    bodyLarge: _baseStyle(
      fontSize: AppFontSize.bodyLarge,
      fontWeight: AppFontWeight.regular,
      height: 1.5,
      letterSpacing: 0.15,
    ),
    bodyMedium: _baseStyle(
      fontSize: AppFontSize.bodyMedium,
      fontWeight: AppFontWeight.regular,
      height: 1.5,
      letterSpacing: 0.25,
    ),
    bodySmall: _baseStyle(
      fontSize: AppFontSize.bodySmall,
      fontWeight: AppFontWeight.regular,
      height: 1.5,
      letterSpacing: 0.4,
    ),

    // ----- Label (buttons, chips, form fields) -----
    labelLarge: _baseStyle(
      fontSize: AppFontSize.labelLarge,
      fontWeight: AppFontWeight.semiBold,
      height: 1.4,
      letterSpacing: 0.1,
    ),
    labelMedium: _baseStyle(
      fontSize: AppFontSize.labelMedium,
      fontWeight: AppFontWeight.medium,
      height: 1.4,
      letterSpacing: 0.5,
    ),
    labelSmall: _baseStyle(
      fontSize: AppFontSize.labelSmall,
      fontWeight: AppFontWeight.medium,
      height: 1.4,
      letterSpacing: 0.5,
    ),
  );

  // ============================================================
  // One-off styles for things outside the Material type scale
  // ============================================================

  /// Invoice total / big currency display.
  static final TextStyle currencyLarge = _baseStyle(
    fontSize: 32,
    fontWeight: AppFontWeight.extraBold,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Invoice number / reference codes.
  static final TextStyle mono =
      _baseStyle(
        fontSize: AppFontSize.bodyMedium,
        fontWeight: AppFontWeight.medium,
        height: 1.5,
      ).copyWith(
        fontFamily: 'monospace',
        fontFeatures: [const FontFeature.tabularFigures()],
      );

  /// Status badges (PAID, OVERDUE, etc.).
  static final TextStyle badge = _baseStyle(
    fontSize: 11,
    fontWeight: AppFontWeight.bold,
    height: 1.0,
    letterSpacing: 0.8,
  );

  /// Section headers in lists / forms.
  static final TextStyle sectionHeader = _baseStyle(
    fontSize: 13,
    fontWeight: AppFontWeight.semiBold,
    height: 1.4,
    letterSpacing: 0.8,
  );

  /// Subtle hint / placeholder text.
  static final TextStyle hint = _baseStyle(
    fontSize: AppFontSize.bodySmall,
    fontWeight: AppFontWeight.regular,
    height: 1.5,
    letterSpacing: 0.25,
  );
}

// ============================================================
// Variable Font Extension — use vCopyWith everywhere
// ============================================================
extension VariableFontStyle on TextStyle {
  /// Drop-in replacement for [copyWith] that keeps [fontVariations]
  /// in sync with [fontWeight]. Use this instead of [copyWith] when
  /// changing weight so variable fonts render correctly on web.
  TextStyle vCopyWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    TextOverflow? overflow,
    List<FontFeature>? fontFeatures,
    List<String>? fontFamilyFallback,
  }) {
    final resolvedWeight = fontWeight ?? this.fontWeight;

    // Preserve existing non-wght variations and update wght.
    final updatedVariations = <FontVariation>[
      if (fontVariations != null)
        ...fontVariations!.where((v) => v.axis != 'wght'),
      if (resolvedWeight != null)
        FontVariation('wght', resolvedWeight.value.toDouble()),
    ];

    return copyWith(
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      leadingDistribution: leadingDistribution,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      overflow: overflow,
      fontFeatures: fontFeatures,
      fontFamilyFallback: fontFamilyFallback,
      fontVariations: updatedVariations,
    );
  }
}
