import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryAccent,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.background,
        onSurface: AppColors.primaryText,
        onError: AppColors.primaryText,
      ),
      textTheme: AppTypography.getTextTheme(
        textColor: AppColors.primaryText,
        secondaryTextColor: AppColors.secondaryText,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cards,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryText),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryAccent,
        surface: AppColors.lightSurface,
        error: AppColors.error,
        onPrimary: AppColors.lightBackground,
        onSurface: AppColors.lightPrimaryText,
        onError: AppColors.lightPrimaryText,
      ),
      textTheme: AppTypography.getTextTheme(
        textColor: AppColors.lightPrimaryText,
        secondaryTextColor: AppColors.lightSecondaryText,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCards,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.lightPrimaryText),
      ),
    );
  }
}
