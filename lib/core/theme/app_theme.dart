import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_cipher/core/constants/app_colors.dart';

class AppTheme {
  static TextStyle cipherTextStyle = GoogleFonts.googleSansCode(
    fontSize: 24,
    letterSpacing: 1.5,
    color: AppColors.textPrimary,
  );

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.mainBackground,
      primaryColor: AppColors.primaryPurple,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryPurple,
        surface: AppColors.surfaceLight,
      ),

      textTheme: TextTheme(
        bodyLarge: GoogleFonts.montserrat(
          color: AppColors.textPrimary,
          fontSize: 24,
        ),
        bodyMedium: GoogleFonts.montserrat(
          color: AppColors.textPrimary,
          fontSize: 18,
        ),
        bodySmall: GoogleFonts.montserrat(
          color: AppColors.textSecondary,
          fontSize: 18,
        ),
        titleLarge: GoogleFonts.encodeSansSc(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        hintStyle: GoogleFonts.montserrat(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.all(16),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          foregroundColor: AppColors.textPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
