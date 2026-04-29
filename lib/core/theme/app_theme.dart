import 'package:flutter/material.dart';
import 'package:mycatalog/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  // ── DARK ─────────────────────────────────────────────────
static ThemeData get dark {
  return ThemeData(
    brightness: Brightness.dark,                     // ← gelap
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      primary: AppColors.accent,                     // ← biru MUDA (lebih kontras di gelap)
      surface: AppColors.darkSurface, seedColor: AppColors.darkBackground,                // ← abu gelap
    ),
    scaffoldBackgroundColor: AppColors.darkBackground, // ← hitam gelap
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,        // ← abu gelap (bukan hitam polos)
      foregroundColor: AppColors.darkTextPrimary,    // ← putih keabu
    ),
    // Light: background input = abu sangat muda
    inputDecorationTheme: InputDecorationTheme(
      filled: true,               
      fillColor: Colors.grey.shade50,
   
      border: OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey.shade300)
)


      // Dark: background input = abu gelap
      fillColor: AppColors.darkSurfaceCard,
      border: BorderSide(color: AppColors.darkBorder),
      focusedBorder: BorderSide(color: AppColors.accent, width: 2),
      hintStyle: TextStyle(color: AppColors.darkTextHint),

  );
}

}
