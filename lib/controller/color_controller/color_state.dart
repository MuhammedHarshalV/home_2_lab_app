import 'package:flutter/material.dart';

class ColorState {
  final Color primaryColor;
  final Color secondaryColor;

  const ColorState({
    this.primaryColor = const Color.fromARGB(255, 21, 130, 24),
    this.secondaryColor = const Color.fromARGB(255, 216, 250, 217),
  });

  ColorState copyWith({Color? primaryColor, Color? secondaryColor}) {
    return ColorState(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }
}
