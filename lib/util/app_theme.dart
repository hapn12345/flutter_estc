import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  get darkTheme => ThemeData(
        primaryColor: Colors.blue[300],
        backgroundColor: Colors.black,
        fontFamily: GoogleFonts.getFont('Poppins').fontFamily,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
        toggleableActiveColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primaryColorDark: Colors.black,
          accentColor: Colors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(color: Colors.white),
          unselectedIconTheme: IconThemeData(color: Colors.black),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      );

  get lightTheme => ThemeData(
        primaryColor: Colors.blue[600],
        brightness: Brightness.light,
        backgroundColor: Colors.grey[100],
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
        fontFamily: GoogleFonts.getFont('Poppins').fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      );
}
