import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wha_bytes/core/typography.dart';

class AppTheme {
  // Light Theme Colors
  static const _primaryLight = Color(0xFF6366F1);  // Indigo
  static const _secondaryLight = Color(0xFF60A5FA); // Blue
  static const _accentLight = Color(0xFF34D399);    // Emerald
  static const _backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const _surfaceLight = Colors.white;
  static const _errorLight = Color(0xFFEF4444);     // Red

  // Dark Theme Colors
  static const _primaryDark = Color(0xFF818CF8);    // Indigo lighter
  static const _secondaryDark = Color(0xFF7DD3FC);  // Blue lighter
  static const _accentDark = Color(0xFF6EE7B7);     // Emerald lighter
  static const _backgroundDark = Color(0xFF0F172A);  // Slate 900
  static const _surfaceDark = Color(0xFF1E293B);    // Slate 800
  static const _errorDark = Color(0xFFFCA5A5);      // Red lighter

  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF6366F1),
    scaffoldBackgroundColor: Colors.grey[50],
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF6366F1),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF6366F1),
      secondary: Colors.indigo[400]!,
      surface: Colors.white,
      background: Colors.grey[50]!,
      onBackground: Colors.black87,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFF6366F1),
    scaffoldBackgroundColor: const Color(0xFF121212),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF6366F1),
      secondary: Colors.indigo[400]!,
      surface: const Color(0xFF1E1E1E),
      background: const Color(0xFF121212),
      onBackground: Colors.white,
    ),
    cardColor: const Color(0xFF1E1E1E),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
    ),
  );

  // Custom Colors
  static const Color taskPriorityLow = Color(0xFF63ECFF);
  static const Color taskPriorityMedium = Color(0xFFFFBE0B);
  static const Color taskPriorityHigh = Color(0xFFFF006E);
  
  // Custom Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF584DFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF21D375), Color(0xFF1AB563)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Custom Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: const Color(0xFF6C63FF).withOpacity(0.1),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: const Color(0xFF6C63FF).withOpacity(0.3),
      blurRadius: 15,
      offset: const Offset(0, 8),
    ),
  ];
}

// Custom Decorations
class AppDecorations {
  static BoxDecoration taskCardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF6C63FF).withOpacity(0.08),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static BoxDecoration gradientButtonDecoration = BoxDecoration(
    gradient: AppTheme.primaryGradient,
    borderRadius: BorderRadius.circular(16),
    boxShadow: AppTheme.buttonShadow,
  );
}

// Custom Text Styles
class AppTextStyles {
  static TextStyle taskTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF2D3436),
  );

  static TextStyle taskDescription = GoogleFonts.poppins(
    fontSize: 14,
    color: const Color(0xFF636E72),
  );

  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
} 