import 'package:app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static const double _radiusMd = 12.0;
  static const double _radiusSm = 8.0;

  // static TextTheme _textTheme(Brightness brightness) {
  //   final base = brightness == Brightness.light
  //       ? Typography.material2021().black
  //       : Typography.material2021().white;
  //   return GoogleFonts.interTextTheme(base);
  // }

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.teal600,
      brightness: Brightness.light,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: AppTypography.textTheme,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.slate900,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.slate600),
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          side: const BorderSide(color: AppColors.slate200),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal600,
          foregroundColor: AppColors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusMd),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.teal600,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusMd),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.teal700,
          minimumSize: const Size.fromHeight(48),
          side: const BorderSide(color: AppColors.teal600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusMd),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          borderSide: const BorderSide(color: AppColors.slate200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          borderSide: const BorderSide(color: AppColors.teal600, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.slate100,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusSm),
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.slate600, size: 24),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.teal600,
      brightness: Brightness.dark,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: AppTypography.darkTextTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.slate800,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.slate300),
      ),
      cardTheme: CardThemeData(
        color: AppColors.slate800,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          side: const BorderSide(color: AppColors.slate700),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal600,
          foregroundColor: AppColors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusMd),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          borderSide: const BorderSide(color: AppColors.slate700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          borderSide: const BorderSide(color: AppColors.slate700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          borderSide: const BorderSide(color: AppColors.teal500, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMd),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.slate700,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusSm),
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.slate300, size: 24),
    );
  }
}
