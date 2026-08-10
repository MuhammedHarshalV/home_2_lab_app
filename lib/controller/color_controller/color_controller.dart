import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/color_controller/color_state.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorController extends StateNotifier<ColorState> {
  ColorController() : super(ColorState()) {
    loadColors();
  }
  Future<void> updateState({
    Color? primaryColor,
    Color? secondaryColor,
    Color? appbarColor,
  }) async {
    if (primaryColor != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('primaryColor', primaryColor.value);
    }
    if (secondaryColor != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('secondaryColor', secondaryColor.value);
    }
    if (appbarColor != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('appbarColor', appbarColor.value);
    }

    state = state.copyWith(
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      appbarColor: appbarColor,
    );
  }

  Future<void> defaultColor({
    Color? primaryColor,
    Color? secondaryColor,
    Color? appbarColor,
  }) async {
    if (primaryColor != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('primaryColor');
    }
    if (secondaryColor != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('secondaryColor');
    }
    if (appbarColor != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('appbarColor');
    }

    state = state.copyWith(
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      appbarColor: appbarColor,
    );
  }

  //load stored color
  Future<void> loadColors() async {
    final prefs = await SharedPreferences.getInstance();

    final int? primary = prefs.getInt('primaryColor');
    final int? secondary = prefs.getInt('secondaryColor');
    final int? appbarColor = prefs.getInt('appbarColor');

    state = state.copyWith(
      primaryColor: primary != null
          ? Color(primary)
          : const Color.fromARGB(255, 21, 130, 24),
      secondaryColor: secondary != null
          ? Color(secondary)
          : const Color.fromARGB(255, 216, 250, 217),
      appbarColor: appbarColor != null
          ? Color(appbarColor)
          : AppColors.appWhite,
    );
  }
}

final colorProvider = StateNotifierProvider<ColorController, ColorState>((ref) {
  return ColorController();
});
