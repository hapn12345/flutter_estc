import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class AppTheme {
  get darkTheme => ThemeData(
        appBarTheme: const AppBarTheme(
            color: AppColors.textBlack,
            systemOverlayStyle: SystemUiOverlayStyle.light),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        brightness: Brightness.dark,
        canvasColor: AppColors.lightGreyDarkMode,
      );

  get lightTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          color: AppColors.grey2,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        canvasColor: AppColors.white,
        brightness: Brightness.light,
      );
}
