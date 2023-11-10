import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'dimens.dart';

class AppTheme {
  static ThemeData current(BuildContext context) {
    final originalTextTheme = Theme.of(context).textTheme;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      inversePrimary: AppColors.primaryVariant,
      onBackground: AppColors.text,
    );

    final textTheme = GoogleFonts.nunitoTextTheme(originalTextTheme).apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    );

    const buttonPadding = EdgeInsets.all(AppDimens.padding / 2);

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.secondaryPadding / 2),
    );

    return ThemeData(
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      disabledColor: AppColors.disabledColor,
      dividerTheme: const DividerThemeData(
        thickness: 1,
        // color: AppColors.fieldBorderVariant,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.background,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedIconTheme: IconThemeData(color: colorScheme.onSurface),
        unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      ),
      colorScheme: colorScheme.copyWith(
        surfaceTint: colorScheme.surface,
        shadow: colorScheme.onBackground.withOpacity(.3),
      ),
      useMaterial3: true,
      textTheme: textTheme,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.secondaryPadding / 2),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: buttonPadding,
          shape: buttonShape,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: buttonPadding,
          shape: buttonShape,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: buttonPadding,
          shape: buttonShape,
          foregroundColor: colorScheme.inversePrimary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: buttonPadding,
          shape: buttonShape,
          side: BorderSide(color: colorScheme.primary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.secondaryPadding / 2),
          borderSide: const BorderSide(color: AppColors.textFieldBorder),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.secondaryPadding / 2),
          borderSide: const BorderSide(color: AppColors.disabledColor),
        ),
        hintStyle: const TextStyle(color: AppColors.textFieldHint),
        contentPadding: const EdgeInsets.all(AppDimens.secondaryPadding),
        filled: true,
        fillColor: AppColors.textFieldBackground,
      ),
    );
  }
}
