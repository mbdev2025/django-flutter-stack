import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Couleurs principales (Inspiré du seed #6750A4)
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color secondaryColor = Color(0xFFEADDFF); // Nuance claire
  static const Color backgroundColor = Color(0xFFFDFBFF); // Fond clair
  static const Color surfaceColor = Color(0xFFFDFBFF); // Surface cartes
  static const Color errorColor = Color(0xFFBA1A1A);

  // Thème Clair (Light Mode)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        surface: backgroundColor,
      ),
      
      // Typographie (Google Fonts Inter)
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),

      // Style des AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),

      // Style des Boutons (ElevatedButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Style des Cartes (Card)
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 2,
        shadowColor: primaryColor.withOpacity(0.2),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Coins arrondis modernes
        ),
      ),

      // Style des Inputs (TextField)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondaryColor.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  // Thème Sombre (Dark Mode) - Optionnel pour l'instant
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );
  }
}
