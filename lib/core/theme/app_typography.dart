import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Display Font: Space Grotesk
  static TextStyle get displayLarge => GoogleFonts.spaceGrotesk(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      );

  static TextStyle get displayMedium => GoogleFonts.spaceGrotesk(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle get displaySmall => GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  // Large Calculation Results
  static TextStyle get calculationResult => GoogleFonts.spaceGrotesk(
        fontSize: 64,
        fontWeight: FontWeight.w600, // SemiBold
        letterSpacing: -1.5,
      );

  // Body Font: Inter
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      );

  // Labels
  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500, // Medium
        letterSpacing: 0.1,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500, // Medium
        letterSpacing: 0.5,
      );

  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500, // Medium
        letterSpacing: 0.5,
      );

  // History (Regular)
  static TextStyle get historyText => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      );

  static TextTheme getTextTheme({required Color textColor, required Color secondaryTextColor}) {
    return TextTheme(
      displayLarge: displayLarge.copyWith(color: textColor),
      displayMedium: displayMedium.copyWith(color: textColor),
      displaySmall: displaySmall.copyWith(color: textColor),
      bodyLarge: bodyLarge.copyWith(color: textColor),
      bodyMedium: bodyMedium.copyWith(color: secondaryTextColor),
      bodySmall: bodySmall.copyWith(color: secondaryTextColor),
      labelLarge: labelLarge.copyWith(color: textColor),
      labelMedium: labelMedium.copyWith(color: secondaryTextColor),
      labelSmall: labelSmall.copyWith(color: secondaryTextColor),
    );
  }
}
