import 'package:flutter/material.dart';
import 'package:shopsavvy/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData get getTheme => ThemeData(
        primaryColor: AppColors.darkBlue,
        colorScheme: ColorScheme.light(
          onPrimary: AppColors.bombay,
          secondary: AppColors.lightGrey,
          onSecondary: AppColors.concrete,
          tertiary: AppColors.dustyGrey,
          onTertiary: AppColors.grey,
          error: AppColors.red,
        ),
        textTheme: const TextTheme(
          titleLarge: titleBoldStyle,
          titleMedium: titleMediumStyle,
          titleSmall: titleRegularStyle,
          labelSmall: labelRegularStyle,
          bodyMedium: bodyMediumStyle,
          bodySmall: bodyRegularStyle,
        ),
      );

  static const TextStyle titleBoldStyle = TextStyle(
    color: Color(0xFF1E2022),
    fontFamily: 'SF Pro Text',
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 1,
  );
  static const TextStyle titleRegularStyle = TextStyle(
    color: Color(0xFF77838F),
    fontSize: 14,
    fontFamily: 'SF Pro Text',
    fontWeight: FontWeight.w400,
    letterSpacing: 1,
  );

  static const TextStyle titleMediumStyle = TextStyle(
    color: Color(0xFF1E2022),
    fontFamily: 'SF Pro Text',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 1,
  );
  static const TextStyle bodyMediumStyle = TextStyle(
    color: Color(0xFF1E2022),
    fontFamily: 'SF Pro Text',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 2.4,
    letterSpacing: 1,
  );

  static const TextStyle labelRegularStyle = TextStyle(
    color: Color(0xFFF2F2F2),
    fontFamily: 'SF Pro Text',
    fontWeight: FontWeight.normal,
    fontSize: 12,
    letterSpacing: 1,
  );
  static const TextStyle bodyRegularStyle = TextStyle(
    color: Color(0xFF77838F),
    fontFamily: 'SF Pro Text',
    fontWeight: FontWeight.normal,
    height: 1.8,
    fontSize: 12,
    letterSpacing: 1,
  );

  TextStyle italicStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    fontSize: 16,
  );
}
