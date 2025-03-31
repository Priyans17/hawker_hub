import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Color palette from the Codepen design
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color primaryContainerColor = Color(0xFFEADDFF);
  static const Color secondaryColor = Color(0xFF625B71);
  static const Color secondaryContainerColor = Color(0xFFE8DEF8);
  static const Color tertiaryColor = Color(0xFF7D5260);
  static const Color tertiaryContainerColor = Color(0xFFFFD8E4);
  static const Color surfaceColor = Color(0xFFFFFBFE);
  static const Color surfaceVariantColor = Color(0xFFE7E0EC);
  static const Color backgroundColor = Color(0xFFFFFBFE);
  static const Color errorColor = Color(0xFFB3261E);
  static const Color errorContainerColor = Color(0xFFF9DEDC);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color onSecondaryColor = Color(0xFFFFFFFF);
  static const Color onTertiaryColor = Color(0xFFFFFFFF);
  static const Color onSurfaceColor = Color(0xFF1C1B1F);
  static const Color onSurfaceVariantColor = Color(0xFF49454F);
  static const Color onErrorColor = Color(0xFFFFFFFF);
  static const Color outlineColor = Color(0xFF79747E);
  static const Color shadowColor = Color(0xFF000000);

  // Text styles from the Codepen design
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    color: onSurfaceColor,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    color: onSurfaceColor,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: onSurfaceColor,
  );
  
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: onSurfaceColor,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: onSurfaceColor,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: onSurfaceColor,
  );
  
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: onSurfaceColor,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: onSurfaceColor,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: onSurfaceColor,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: onSurfaceColor,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: onSurfaceColor,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: onSurfaceColor,
  );
  
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: onSurfaceColor,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: onSurfaceColor,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: onSurfaceColor,
  );

  // Button styles matching the Codepen design
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: onPrimaryColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    textStyle: labelLarge,
  );
  
  static ButtonStyle filledButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: onPrimaryColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    textStyle: labelLarge,
  );
  
  static ButtonStyle filledTonalButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryContainerColor,
    foregroundColor: onSurfaceColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    textStyle: labelLarge,
  );
  
  static ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: primaryColor,
    side: BorderSide(color: primaryColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    textStyle: labelLarge,
  );
  
  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    textStyle: labelLarge,
  );

  // Card styles
  static CardTheme cardTheme = CardTheme(
    color: surfaceColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: EdgeInsets.zero,
  );

  // Input decoration theme
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: surfaceVariantColor.withOpacity(0.5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: errorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: errorColor, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: bodyMedium.copyWith(color: onSurfaceVariantColor),
    hintStyle: bodyMedium.copyWith(color: onSurfaceVariantColor),
    errorStyle: bodySmall.copyWith(color: errorColor),
  );

  // AppBar theme
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: surfaceColor,
    foregroundColor: onSurfaceColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: titleLarge.copyWith(fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: surfaceColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Bottom Navigation Bar theme
  static BottomNavigationBarThemeData bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: surfaceColor,
    selectedItemColor: primaryColor,
    unselectedItemColor: onSurfaceVariantColor,
    elevation: 0,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  );

  // Floating Action Button theme
  static FloatingActionButtonThemeData floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: onPrimaryColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  // Divider theme
  static DividerThemeData dividerTheme = DividerThemeData(
    color: outlineColor.withOpacity(0.12),
    thickness: 1,
    space: 0,
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      primaryContainer: primaryContainerColor,
      onPrimaryContainer: primaryColor,
      secondary: secondaryColor,
      onSecondary: onSecondaryColor,
      secondaryContainer: secondaryContainerColor,
      onSecondaryContainer: secondaryColor,
      tertiary: tertiaryColor,
      onTertiary: onTertiaryColor,
      tertiaryContainer: tertiaryContainerColor,
      onTertiaryContainer: tertiaryColor,
      error: errorColor,
      onError: onErrorColor,
      errorContainer: errorContainerColor,
      onErrorContainer: errorColor,
      background: backgroundColor,
      onBackground: onSurfaceColor,
      surface: surfaceColor,
      onSurface: onSurfaceColor,
      surfaceVariant: surfaceVariantColor,
      onSurfaceVariant: onSurfaceVariantColor,
      outline: outlineColor,
      shadow: shadowColor,
    ),
    textTheme: TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyle,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: filledButtonStyle,
    ),
    //filledTonalButtonTheme: FilledTonalButtonThemeData(
      //style: filledTonalButtonStyle,
   // ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: outlinedButtonStyle,
    ),
    textButtonTheme: TextButtonThemeData(
      style: textButtonStyle,
    ),
    cardTheme: cardTheme,
    inputDecorationTheme: inputDecorationTheme,
    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    floatingActionButtonTheme: floatingActionButtonTheme,
    dividerTheme: dividerTheme,
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      primaryContainer: primaryContainerColor,
      onPrimaryContainer: primaryColor,
      secondary: secondaryColor,
      onSecondary: onSecondaryColor,
      secondaryContainer: secondaryContainerColor,
      onSecondaryContainer: secondaryColor,
      tertiary: tertiaryColor,
      onTertiary: onTertiaryColor,
      tertiaryContainer: tertiaryContainerColor,
      onTertiaryContainer: tertiaryColor,
      error: errorColor,
      onError: onErrorColor,
      errorContainer: errorContainerColor,
      onErrorContainer: errorColor,
      background: Color(0xFF1C1B1F),
      onBackground: onSurfaceColor,
      surface: Color(0xFF1C1B1F),
      onSurface: onSurfaceColor,
      surfaceVariant: Color(0xFF49454F),
      onSurfaceVariant: Color(0xFFCAC4D0),
      outline: Color(0xFF938F99),
      shadow: shadowColor,
    ),
    textTheme: TextTheme(
      displayLarge: displayLarge.copyWith(color: onPrimaryColor),
      displayMedium: displayMedium.copyWith(color: onPrimaryColor),
      displaySmall: displaySmall.copyWith(color: onPrimaryColor),
      headlineLarge: headlineLarge.copyWith(color: onPrimaryColor),
      headlineMedium: headlineMedium.copyWith(color: onPrimaryColor),
      headlineSmall: headlineSmall.copyWith(color: onPrimaryColor),
      titleLarge: titleLarge.copyWith(color: onPrimaryColor),
      titleMedium: titleMedium.copyWith(color: onPrimaryColor),
      titleSmall: titleSmall.copyWith(color: onPrimaryColor),
      bodyLarge: bodyLarge.copyWith(color: onPrimaryColor),
      bodyMedium: bodyMedium.copyWith(color: onPrimaryColor),
      bodySmall: bodySmall.copyWith(color: onPrimaryColor),
      labelLarge: labelLarge.copyWith(color: onPrimaryColor),
      labelMedium: labelMedium.copyWith(color: onPrimaryColor),
      labelSmall: labelSmall.copyWith(color: onPrimaryColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyle,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: filledButtonStyle,
    ),
    //filledTonalButtonTheme: FilledTonalButtonThemeData(
      //style: filledTonalButtonStyle.copyWith(
        //backgroundColor: MaterialStateProperty.all(secondaryContainerColor),
      //),
    //),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: outlinedButtonStyle.copyWith(
        side: MaterialStateProperty.all(BorderSide(color: primaryColor)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: textButtonStyle,
    ),
    cardTheme: cardTheme.copyWith(
      color: Color(0xFF1C1B1F),
    ),
    inputDecorationTheme: inputDecorationTheme.copyWith(
      filled: true,
      fillColor: Color(0xFF49454F).withOpacity(0.5),
    ),
    appBarTheme: appBarTheme.copyWith(
      backgroundColor: Color(0xFF1C1B1F),
      foregroundColor: onPrimaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF1C1B1F),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: bottomNavigationBarTheme.copyWith(
      backgroundColor: Color(0xFF1C1B1F),
      selectedItemColor: primaryColor,
      unselectedItemColor: onSurfaceVariantColor,
    ),
    floatingActionButtonTheme: floatingActionButtonTheme.copyWith(
      backgroundColor: primaryColor,
      foregroundColor: onPrimaryColor,
    ),
    dividerTheme: dividerTheme.copyWith(
      color: outlineColor.withOpacity(0.12),
    ),
  );
}