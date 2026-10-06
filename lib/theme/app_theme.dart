import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary cute palette
  static const Color primary = Color(0xFFFF6B6B);
  static const Color primaryLight = Color(0xFFFF8E72);
  static const Color primaryPastel = Color(0xFFFFE3E3);

  // Accent & Secondary
  static const Color mint = Color(0xFF4ECDC4);
  static const Color mintLight = Color(0xFFE0F9F6);
  static const Color yellow = Color(0xFFFFD166);
  static const Color yellowLight = Color(0xFFFFF7DB);
  static const Color purple = Color(0xFF9B5DE5);
  static const Color purpleLight = Color(0xFFF2E6FF);
  static const Color sky = Color(0xFF00BBF9);
  static const Color skyLight = Color(0xFFE5F7FF);
  static const Color pink = Color(0xFFF15BB5);
  static const Color pinkLight = Color(0xFFFFEBF6);

  // Neutrals & Backgrounds
  static const Color background = Color(0xFFFAF7F2);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF4EFE6);
  static const Color textMain = Color(0xFF2C3437);
  static const Color textMuted = Color(0xFF88929A);
  static const Color border = Color(0xFFEDE8DF);
  static const Color inputBg = Color(0xFFF8F5EE);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E72)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient mintSkyGradient = LinearGradient(
    colors: [Color(0xFF4ECDC4), Color(0xFF00BBF9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFFD166)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient y2kGradient = LinearGradient(
    colors: [Color(0xFFF15BB5), Color(0xFF9B5DE5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.mint,
        surface: AppColors.cardBg,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textMain,
      ),
      textTheme: GoogleFonts.promptTextTheme().apply(
        bodyColor: AppColors.textMain,
        displayColor: AppColors.textMain,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.textMain),
        titleTextStyle: GoogleFonts.prompt(
          color: AppColors.textMain,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.prompt(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primaryPastel,
        labelStyle: GoogleFonts.prompt(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textMain,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: GoogleFonts.prompt(
          color: AppColors.textMuted,
          fontSize: 14,
        ),
      ),
    );
  }
}
