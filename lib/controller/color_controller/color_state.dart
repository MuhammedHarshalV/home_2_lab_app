import 'package:flutter/material.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class ColorState {
  final Color primaryColor;
  final Color secondaryColor;
  final Color appbarColor;

  const ColorState({
    this.primaryColor = const Color.fromARGB(255, 21, 130, 24),
    this.secondaryColor = const Color.fromARGB(255, 216, 250, 217),
    this.appbarColor = AppColors.appWhite,
  });

  ColorState copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? appbarColor,
  }) {
    return ColorState(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      appbarColor: appbarColor ?? this.appbarColor,
    );
  }
}
