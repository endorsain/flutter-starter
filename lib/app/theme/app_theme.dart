import 'package:flutter/material.dart';

enum AppThemeId { cosmo, wanda }

class AppTheme {
  AppTheme._();

  static const String? fontFamily = null;
  static final TextTheme textTheme = Typography.material2021().black.apply(
    fontFamily: fontFamily,
  );

  static ThemeData fromId(AppThemeId themeId) {
    return switch (themeId) {
      AppThemeId.cosmo => _buildTheme(
        primary: const Color(0xFFA3D99B),
        secondary: const Color(0xFF669060),
        button: const Color(0xFF7ABD70),
        surface: const Color(0xFFF7FAF6),
      ),
      AppThemeId.wanda => _buildTheme(
        primary: const Color(0xFFD99BD8),
        secondary: const Color(0xFFAE57AC),
        button: const Color(0xFF883387),
        surface: const Color(0xFFFCF6FC),
      ),
    };
  }

  static ThemeData _buildTheme({
    required Color primary,
    required Color secondary,
    required Color button,
    required Color surface,
  }) {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: primary,
          onPrimary: Colors.black,
          secondary: secondary,
          onSecondary: Colors.white,
          tertiary: button,
          onTertiary: Colors.white,
          surface: surface,
          onSurface: const Color(0xFF252225),
          error: const Color(0xFFB3261E),
          onError: Colors.white,
          outline: secondary,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.primary,
      fontFamily: fontFamily,
      textTheme: textTheme,
      extensions: const <ThemeExtension<dynamic>>[
        AppThemeColors(inputForeground: Colors.white),
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSecondary,
        ),
        toolbarTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSecondary,
        ),
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.secondary,
        indicatorColor: colorScheme.tertiary,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStatePropertyAll<IconThemeData>(
          IconThemeData(color: colorScheme.primary),
        ),
        labelTextStyle: WidgetStatePropertyAll<TextStyle?>(
          textTheme.labelMedium?.copyWith(color: colorScheme.primary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.primary,
        contentPadding: AppThemeDimensions.inputPadding,
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.65),
        ),
        labelStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
        floatingLabelStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.secondary,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(color: colorScheme.error),
        border: _inputBorder(colorScheme.outline),
        enabledBorder: _inputBorder(colorScheme.outline),
        focusedBorder: _inputBorder(colorScheme.secondary, width: 2),
        errorBorder: _inputBorder(colorScheme.error),
        focusedErrorBorder: _inputBorder(colorScheme.error, width: 2),
        disabledBorder: _inputBorder(
          colorScheme.onSurface.withValues(alpha: 0.25),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll<Size>(
            Size.fromHeight(AppThemeDimensions.buttonHeight),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            AppThemeDimensions.buttonPadding,
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppThemeDimensions.controlRadius,
              ),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withValues(alpha: 0.12);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary;
            }
            return colorScheme.tertiary;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withValues(alpha: 0.38);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.onPrimary;
            }
            return colorScheme.onTertiary;
          }),
          overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.pressed) ||
                states.contains(WidgetState.disabled)) {
              return Colors.transparent;
            }
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return colorScheme.onTertiary.withValues(alpha: 0.08);
            }
            return null;
          }),
        ),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppThemeDimensions.controlRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({required this.inputForeground});

  final Color inputForeground;

  @override
  AppThemeColors copyWith({Color? inputForeground}) {
    return AppThemeColors(
      inputForeground: inputForeground ?? this.inputForeground,
    );
  }

  @override
  AppThemeColors lerp(covariant AppThemeColors? other, double t) {
    if (other == null) {
      return this;
    }

    return AppThemeColors(
      inputForeground: Color.lerp(inputForeground, other.inputForeground, t)!,
    );
  }
}

class AppThemeDimensions {
  AppThemeDimensions._();

  static const double formPadding = 24;
  static const double formSpacing = 16;
  static const double controlRadius = 16;
  static const double buttonHeight = 52;
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 16,
  );
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 14,
  );
}
