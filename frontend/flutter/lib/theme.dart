import 'package:flutter/material.dart';

// ponytail: plain constants, no ThemeExtension abstraction until 2nd theme needed
abstract class FitColors {
  static const bg = Color(0xFF121212);
  static const surface = Color(0xFF1E1E1E);
  static const surface2 = Color(0xFF2A2A2A);
  static const line = Color(0xFF2E3338);
  static const text = Color(0xFFEDEFE9);
  static const muted = Color(0xFF9AA0A6);
  static const volt = Color(0xFFC6FF00);
  static const voltDim = Color(0xFF9FD028);
  static const heat = Color(0xFFFF5B3D);
}

ThemeData fitTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: FitColors.bg,
    canvasColor: FitColors.bg,
    cardColor: FitColors.surface,
    dividerColor: FitColors.line,
    colorScheme: const ColorScheme.dark(
      primary: FitColors.volt,
      surface: FitColors.surface,
      onSurface: FitColors.text,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: FitColors.text,
          displayColor: FitColors.text,
        ),
  );
}

// Archivo Black -> FontWeight.w900 + tight spacing (add google_fonts only if exact match needed)
class FitText {
  static TextStyle display(double size) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.5,
        height: 1.05,
        color: FitColors.text,
      );
  static TextStyle body(double size, {Color? color, FontWeight? weight}) =>
      TextStyle(
        fontSize: size,
        fontWeight: weight ?? FontWeight.w500,
        color: color ?? FitColors.text,
      );
  static TextStyle sectionHead() => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: FitColors.muted,
      );
}
